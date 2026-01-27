import { For, Switch, Match, createSignal } from 'solid-js';
import { artists, rules } from '../utils/fantasifestivalen-globals';
import { supabase } from '../utils/supabase';

enum LoadStatus {
  none,
  processing,
  success,
  fail,
}

const [heat, setHeat] = createSignal("1")
const [artist, setArtist] = createSignal("");
const [rule, setRule] = createSignal("");
const [loading, setLoading] = createSignal<LoadStatus>(LoadStatus.none);

async function postEvent(artist: string, rule: string) {
  console.log(artist);
  console.log(rule);
  setLoading(LoadStatus.processing);
  let result = await supabase.from("events").insert({ "artist": artist, "rule": rule });
  if (result.error) {
    setLoading(LoadStatus.fail);
  }
  else {
    setLoading(LoadStatus.success);
  }
  setTimeout((() => { setLoading(LoadStatus.none) }), 2000);
}

export default function Backend() {
  return (
    <section class="bg-gray-100 text-gray-700 p-8">
      <h1 class="text-2xl font-bold">Fantasifestivalen</h1>
      <form on:submit={(e) => {
        e.preventDefault();
        postEvent(artist(), rule());
      }}>
        <label for='heat'>Deltävling: </label>
        <select id='heat' onInput={
          (e) => { setHeat(e.currentTarget.value); setArtist(""); }
        }>
          <option value="1">1</option>
          <option value="2">2</option>
          <option value="3">3</option>
          <option value="4">4</option>
          <option value="5">5</option>
        </select>
        <br />
        <label for='artist'>Artist: </label>
        <select id='artist' value={artist()} onInput={
          (e) => { setArtist(e.currentTarget.value) }
        }>
          <For each={artists()?.filter(a => a.heat.toString() === heat())}>
            {(item, index) => <option value={item.id}>{item.name}</option>}
          </For>
        </select>
        <br />
        <label for='rule'>Regel: </label>
        <select id='rule' onInput={
          (e) => { setRule((e.currentTarget.value)) }
        }>
          <For each={rules()}>
            {(item) => <option value={item.id}>{item.name}</option>}
          </For>
        </select>
        <br />
        <input class="bg-purple-400" type='submit' />
      </form>
      <Switch>
        <Match when={loading() == LoadStatus.processing}>
          ...
        </Match>
        <Match when={loading() == LoadStatus.success}>
          ✅
        </Match>
        <Match when={loading() == LoadStatus.processing}>
          ✖️
        </Match>
      </Switch>
    </section>
  );
}
