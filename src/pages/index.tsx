import { createSignal, Index, onMount, Show } from 'solid-js';
import { Portal } from 'solid-js/web';
import { ArtistBox, ArtistPopup } from '../utils/fantasifestivalen-modules';
import { localTeamName, setLocalTeamName, user, supabase, getArtistById, localTeam, selectedArtist, stagedTransactions, teamName, remoteTeam } from '../utils/fantasifestivalen-globals';
import { A } from '@solidjs/router';

async function submitTeam() {
  if (remaining() >= 0) {
    await Promise.all([
      supabase.from("user_artist_buys").insert(stagedTransactions.transactions.filter(x => x.type == "buy").map(x => { const { type, ...y } = x; return y })),
      supabase.from("user_artist_sells").insert(stagedTransactions.transactions.filter(x => x.type == "sell").map(x => { const { type, ...y } = x; return y })),
      supabase.from("user_teamnames").insert({ teamname: localTeamName() }),
    ]);
  }
};

function remaining() {
  return 100 - localTeam().map(element => { return getArtistById(element)?.cost ?? 0 })?.reduce((a, b) => a + b, 0);
}



export default function Home() {
  onMount(() => {
  });
  return (
    <section class="p-8">
      <Show when={selectedArtist() != null} keyed>
        <Portal mount={document.querySelector("main") ?? undefined}>
          {ArtistPopup({ artist: selectedArtist() })}
        </Portal>
      </Show>
      <Show when={(teamName() ?? "").length == 0}
        fallback={<h1 class="text-4xl font-bold my-16">{teamName()}</h1>}
      >
        <input
          class="text-4xl font-bold w-full my-16"
          placeholder="Ge ditt lag ett namn..."
          value={localTeamName() ?? ""}
          onInput={(e) => setLocalTeamName(e.target.value)}
          required
        />
      </Show>
      <Show when={localTeam()?.length > 0}>
        <div class="flex flex-wrap justify-center">
          <Index each={localTeam()}>
            {(item, _) =>
              <ArtistBox artist={getArtistById(item())} />
            }
          </Index>
        </div>

      </Show>
      <Show when={stagedTransactions.transactions.length > 0}>
        <div class="flex flex-row gap-8 justify-end">
          <span>Poäng kvar: {remaining()}</span>
          <Show when={localTeam().join() != remoteTeam().join()}>
            <Show when={localTeamName()?.length == 0 && localTeam().indexOf(null) >= 0}>
              Obs! Ditt lag måste ha exakt 5 artister och ett namn.
            </Show>
            <Show when={user() != null} fallback={<A href="/account">Loggga in för att skapa ditt lag</A>}>
              <div class="fab">
                <a onClick={() => submitTeam()} class="btn btn-lg btn-circle btn-secondary">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 10 10"
                    stroke-width="2"
                    stroke="currentColor"
                    class="size-6"
                    fill="none"
                  >
                    <path stroke-linecap="round" stroke-linejoin="round" d="M1 5l3 3L9 2" />
                  </svg>
                </a>
              </div>

            </Show>
          </Show>
        </div>
      </Show>
    </section>
  );
}
