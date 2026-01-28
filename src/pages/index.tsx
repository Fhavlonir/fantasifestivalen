import { Index, onMount, Show } from 'solid-js';
import { Portal } from 'solid-js/web';
import { ArtistBox, ArtistPopup } from '../utils/fantasifestivalen-modules';
import { getArtistById, teamName, setTeamName, localTeam, artists, selectedArtist, stagedTransactions } from '../utils/fantasifestivalen-globals';
import { supabase } from '../utils/supabase';

async function submitTeam() {
  if (remaining() >= 0) {
    await Promise.all([
      supabase.from("user_artist_buys").insert(stagedTransactions.transactions.filter(x => x.type == "buy")),
      supabase.from("user_artist_sells").insert(stagedTransactions.transactions.filter(x => x.type == "sell"))
    ]);
  }
};

function remaining() {
  return 100 - localTeam().map(element => { return getArtistById(element)?.cost ?? 0 })?.reduce((a, b) => a + b, 0);
}


function detecttoken() {
  const params = new URLSearchParams(window.location.search);
  const token_hash = params.get("token_hash");
  const paramType = params.get("type");
  if (token_hash) {
    supabase.auth.verifyOtp({
      token_hash,
      type: paramType || "email",
    }).then(({ error }) => {
      if (error) {
        console.log(error.message);
      }
    });
  }
}

export default function Home() {
  onMount(() => {
    detecttoken();
  });
  return (
    <section class="bg-gray-900 text-gray-200 p-8">
      <Show when={selectedArtist() != null} keyed>
        <Portal mount={document.querySelector("main") ?? undefined}>
          {ArtistPopup({ artist: selectedArtist() })}
        </Portal>
      </Show>
      <input
        class="text-4xl font-bold w-full my-16"
        placeholder="Ge ditt lag ett namn..."
        value={teamName()}
        onInput={(e) => setTeamName(e.target.value)}
        required
      />
      <Show when={localTeam()?.length > 0}>
        <div class="flex flex-wrap justify-center">
          <Index each={localTeam()}>
            {(item, index) =>
              <ArtistBox artist={getArtistById(item())} />
            }
          </Index>
        </div>

      </Show>
      <Show when={stagedTransactions.transactions.length > 0}>
        <div class="flex flex-row gap-8 justify-end">
          <span>Poäng kvar: {remaining()}</span>
          <button onClick={submitTeam}>
            ✅
          </button>
        </div>
      </Show>
    </section>
  );
}
