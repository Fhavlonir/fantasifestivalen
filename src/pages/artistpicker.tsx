import { For, createSignal, Show } from 'solid-js';
import { ArtistContainer, ArtistPopup } from '../utils/fantasifestivalen-modules';
import { artists, localTeam } from '../utils/fantasifestivalen-globals';
import { Portal } from 'solid-js/web';
import { selectArtist, selectedArtist } from '../utils/fantasifestivalen-globals';

export default function ArtistPicker() {
  return (
    <section class="bg-gray-700 text-gray-100 p-8">
      <Show when={selectedArtist() != null} keyed>
        <Portal mount={document.querySelector("main") ?? undefined}>
          {ArtistPopup({ artist: selectedArtist() })}
        </Portal>
      </Show>
      <h1 class="text-2xl font-bold">Välj artist</h1>
      <div class="flex justify-center">
        <div class="flex-col w-min">
          <For each={artists()}>
            {(artist, index) => {
              return (localTeam().indexOf(artist?.id) < 0 ? <ArtistContainer artist={artist} /> : <span></span>);
            }}
          </For>
        </div>
      </div>
    </section >
  );
}
