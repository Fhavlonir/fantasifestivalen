import { useNavigate } from '@solidjs/router';
import { user, supabase, remoteTeam } from '../utils/fantasifestivalen-globals';
import { createSignal, onMount, Show, Switch, Match } from 'solid-js';

enum LoadStatus {
  none,
  processing,
  success,
  fail,
}
const [loading, setLoading] = createSignal<LoadStatus>(LoadStatus.none);
const [email, setEmail] = createSignal("");
const [password, setPassword] = createSignal("");
const [userinfo, setUserinfo] = createSignal("");
const [existingAccount, setExistingAccount] = createSignal(false);
const [errorString, setErrorString] = createSignal("");

function register() {
  setLoading(LoadStatus.processing);
  supabase.auth.signUp({
    email: email(),
    password: password()
  }).then((r) => {
    if (r.error == null) {
      setLoading(LoadStatus.success)
      setExistingAccount(true);
    } else {
      setLoading(LoadStatus.fail);
      setErrorString(r.error?.toString() ?? "");
    }
  })
    .finally(async () => setTimeout(() => setLoading(LoadStatus.none), 5000));
}

function login() {
  setLoading(LoadStatus.processing)
  supabase.auth.signInWithPassword({
    email: email(),
    password: password()
  }).then((r) => {
    console.log(r);
    if (r.error == null) {
      setLoading(LoadStatus.success);
      if (remoteTeam()?.length ?? 0 > 0) {
      }
    } else {
      setLoading(LoadStatus.fail);
      setErrorString(r.error?.toString() ?? "");
    }
    supabase.auth.getUser().then((u) => setUserinfo(u.data.user?.email ?? ""));
  })
}
function logout() {
  supabase.auth.signOut();
  setUserinfo("");
}

async function displayuser() {
  setUserinfo(user()?.email ?? "");
};
export default function AccountPage() {
  onMount(() => {
    displayuser();
  });
  return <section class="p-8">
    <h1 class="text-2xl font-bold">Konto</h1>
    <Show when={userinfo().length < 1}
      fallback={
        <div>
          <p>
            {userinfo()}
          </p>
          <button class="btn m-2 bg-primary text-primary-content" onClick={logout}>Logga ut</button>
        </div>
      }
    >
      <Show when={existingAccount()}>
        <form on:submit={(e) => {
          e.preventDefault();
          login();
          setEmail("");
          setPassword("");
        }}>
          <div class="field-block">
            <input
              class="input m-2"
              name="email"
              type="email"
              placeholder="E-post"
              value={email()}
              onInput={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div class="field-block">
            <input
              class="input m-2"
              name="password"
              type="password"
              placeholder="Lösenord"
              value={password()}
              onInput={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button class="btn m-2 bg-primary text-primary-content" type="submit">Logga in</button>
        </form>
        <Switch >
          <Match when={loading() == LoadStatus.processing}>
            ♻️
          </Match>
          <Match when={loading() == LoadStatus.fail}>
            ❌
          </Match>
          <Match when={loading() == LoadStatus.processing}>
            ✅
          </Match>
        </Switch>
        <br />
        <br />
        {errorString()}
        <br />
        Har du inget konto?
        <br />
        <button class="btn m-2 bg-primary text-primary-content" onClick={() => { setExistingAccount(false) }}>Registrera dig här</button>
      </Show>
      <Show when={!existingAccount()}>
        <form on:submit={(e) => {
          e.preventDefault();
          register();
          setEmail("");
          setPassword("");
        }}>
          <div class="field-block">
            <input
              class="input m-2"
              name="email"
              type="email"
              placeholder="E-post"
              value={email()}
              onInput={(e) => setEmail(e.target.value)}
              required
            />
          </div>
          <div class="field-block">
            <input
              class="input m-2"
              name="password"
              type="password"
              placeholder="Lösenord"
              value={password()}
              onInput={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button class="btn m-2 bg-primary text-primary-content" type="submit">Registrera dig</button>
        </form>
        <br />
        <Switch >
          <Match when={loading() == LoadStatus.processing}>
            ♻️
          </Match>
          <Match when={loading() == LoadStatus.fail}>
            ❌
          </Match>
          <Match when={loading() == LoadStatus.processing}>
            ✅
          </Match>
        </Switch>
        {errorString()}
        <br />
        <br />
        Har du redan ett konto?
        <br />
        <button class="btn m-2 bg-primary text-primary-content" onClick={() => { setExistingAccount(true) }}>Logga in här</button>
      </Show>

    </Show>
  </section>
}
