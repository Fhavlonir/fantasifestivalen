import { Artist, Event, Transaction } from './fantasifestivalen-interfaces';
import { getArtistById, rules, selectArtist, selectedArtist, localTeam, stagedTransactions, setStagedTransactions } from './fantasifestivalen-globals';
import { supabase } from './supabase';
import { Show } from 'solid-js';
import { A, useNavigate } from '@solidjs/router';

function boxClicked(artist: Artist | null) {
  if (artist) {
    selectArtist(artist)
  }
  else {
    window.location.href = '/artistpicker';
  }
}

export function ArtistBox(props: { artist: Artist | null }) {
  return <div class="max-w-48 p-4 m-4 flex-column items-center space-x-1 bg-pink-200 hover:bg-pink-100 rounded">
    <Show fallback={
      <a onClick={() => selectArtist(props.artist)}>
        <img class="w-40 h-40 " src={props.artist?.imgUrl} />
        <h5 class="text-gray-900 text-center">{props.artist?.name}</h5>
      </a>
    } when={props.artist == null}>
      <A href="/artistpicker">
        <img class="w-40 h-40 object-top" src="assets/unknown.svg" />
        <h5 class="text-gray-900 text-center">Välj en artist</h5>
      </A>
    </Show>

  </div>
}


async function transactArtist(type: "buy" | "sell") {
  const oldTr: Transaction[] = stagedTransactions.transactions;
  const newTr: Transaction = { type: type, artist: selectedArtist()?.id ?? 0 };
  setStagedTransactions({ "transactions": oldTr.concat([newTr]) });
  selectArtist(null);
}
export function ArtistPopup(props: { artist: Artist | null }) {
  console.log(localTeam());
  const navigate = useNavigate();
  return <div class="fixed grid inset-0 place-content-center">
    <div class="rounded-2xl bg-pink-100 w-196">
      <img class="rounded-t-2xl max-h-196 w-196 object-top" src={props.artist?.imgUrl} />
      <div class="p-4">
        <h2 class="text-2xl my-2">
          {props.artist?.name}
        </h2>
        <h3 class="m-1 italic">
          {props.artist?.song}
        </h3>
        <p class="my-2">
          {props.artist?.description}
        </p>
        <div class="flex justify-between">
          <p class="p-2 m-2 text-center h-10 rounded-full bg-orange-300 font-extrabold">
            Kostnad: {props.artist?.cost}
          </p>
          <p class="p-2 m-2 text-center h-10 rounded-full bg-pink-300 ">
            Nr {props.artist?.startNr} | Deltävling {props.artist?.heat}
          </p>
        </div>

        <div class="flex justify-end space-x-4 text-2xl">
          <Show when={localTeam()?.includes(null)}>
            <button onClick={() => {
              transactArtist("buy");
              navigate("/");
            }
            }>
              ✅
            </button>
          </Show>
          <Show when={!localTeam()?.includes(null)}>
            <button onClick={() => transactArtist("sell")}>
              SÄLJ ARTIST
            </button>
          </Show>
          <button onClick={() => selectArtist(null)}>
            ❌
          </button>
        </div>

      </div>

    </div>
  </div>
}

export function EventContainer(props: { event: Event | null }) {
  return <tr>
    <td> {getArtistById(props.event?.artist ?? null)?.name}    </td>
    <td> {(rules() ?? []).find(r => r.id == props.event?.rule)?.name}    </td>
    <td> {(rules() ?? []).find(r => r.id == props.event?.rule)?.reward}  </td>
  </tr>
}

export function ArtistContainer(props: { artist: Artist }) {
  return <a onClick={() => selectArtist(props.artist)} class="rounded-2xl m-2 w-120 flex bg-gray-300 hover:bg-gray-200">
    <img class="rounded-l-2xl w-48 h-48" src={props.artist.imgUrl ?? 'assets/unknown.svg'} />
    <div class="rounded-r-2xl p-4 flex flex-col justify-between w-72">
      <div class="mb-8">
        <div class="text-gray-900 font-bold text-xl mb-2">{props.artist.name}</div>
        <p class="text-gray-700 italic text-base">{props.artist.song}</p>
      </div>
      <div class="flex justify-between">
        <p class="text-gray-900 p-2 m-2 text-center w-10 h-10 rounded-full bg-orange-300 font-extrabold">
          {props.artist.cost}
        </p>
        <p class="text-gray-900 p-2 m-2 text-center h-10 rounded-full bg-pink-300 ">
          Nr {props.artist.startNr} | Deltävling {props.artist.heat}         </p>

      </div>

    </div>
  </a>;
}
