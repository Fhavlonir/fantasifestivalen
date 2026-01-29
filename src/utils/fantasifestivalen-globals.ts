import { makePersisted } from '@solid-primitives/storage';
import { Transaction, Artist } from './fantasifestivalen-interfaces';
import { createResource, createSignal, createMemo } from 'solid-js';
import { createStore } from 'solid-js/store';
import localforage from 'localforage';
import { createClient } from '@supabase/supabase-js'


const supabaseUrl = 'https://tclfopjrhhqsjmbozyya.supabase.co';
const supabaseKey = 'sb_publishable_UmnJahIC18W7J22BMu0pGg_jGhKNw4n';
export const supabase = createClient(supabaseUrl, supabaseKey);
export const [user, setUser] = createSignal(await supabase.auth.getUser().then((u) => u.data.user));
export const [selectedArtist, selectArtist] = createSignal<Artist | null>(null);
//export const [teamName, setTeamName] = makePersisted(createSignal(""), { storage: localforage });
export const [stagedTransactions, setStagedTransactions] = makePersisted(createStore({ transactions: <Transaction[]>[] }), { storage: localforage });
export const [teamName] = createResource(async () => (await getData("user_teamnames"))?.[0]?.teamname ?? "", { storage: (x) => { const [signal, setSignal] = makePersisted(createSignal(x), { storage: localforage }); return [signal, setSignal] } });
export const [artists] = createResource(async () => await getData("artist_costs"), { storage: (x) => { const [signal, setSignal] = makePersisted(createSignal(x), { storage: localforage }); return [signal, setSignal] } });
export const [rules] = createResource(async () => await getData("rules"), { storage: (x) => { const [signal, setSignal] = makePersisted(createSignal(x), { storage: localforage }); return [signal, setSignal] } });
export const [events] = createResource(async () => await getData("events"), { storage: (x) => { const [signal, setSignal] = makePersisted(createSignal(x), { storage: localforage }); return [signal, setSignal] } });
export const [leaderboard] = createResource(async () => await getData("leaderboard"), { storage: (x) => { const [signal, setSignal] = makePersisted(createSignal(x), { storage: localforage }); return [signal, setSignal] } });
const [teams] = createResource(getData.bind(null, "team"));


export function getArtistById(id: number | null): Artist | null {
  if (!id) {
    return null;
  }
  return artists()?.find(a => a.id == id);
}
async function getData(table: string) {
  const { data } = await supabase.from(table).select();
  return data;
}

export const remoteTeam = createMemo(() => {
  const t = teams();
  if (!t) {
    return undefined;
  };
  const result = t.map((x) => x.artist_id).concat(Array(5 - t.length).fill(null));
  return result;
});

export const localTeam = createMemo(() => {
  let resultingTeam: Array<number | null> = [];
  remoteTeam()?.forEach((a) => {
    resultingTeam.push(a);
  });
  stagedTransactions.transactions.forEach(t => {
    if (t.type == 'sell') {
      resultingTeam[resultingTeam?.indexOf(t.artist) ?? 0] = null;
    }
    else if (t.type = 'buy') {
      resultingTeam[resultingTeam?.indexOf(null)] = t.artist;
    }
  });
  return resultingTeam;
});

