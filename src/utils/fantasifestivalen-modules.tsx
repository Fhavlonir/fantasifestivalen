import { Artist, Event, Transaction } from './fantasifestivalen-interfaces';
import { getArtistById, rules, selectArtist, selectedArtist, localTeam, stagedTransactions, setStagedTransactions } from './fantasifestivalen-globals';
import { Show } from 'solid-js';
import { A, useNavigate } from '@solidjs/router';

export function ArtistBox(props: { artist: Artist | null }) {
  return <div class="max-w-48 p-4 m-4 card bg-primary text-primary-content">
    <Show fallback={
      <a onClick={() => { selectArtist(props.artist); document.getElementById('ArtistPopup-modal')?.showModal() }} >
        <figure>
          <img class="w-40 h-40 object-top" src={props.artist?.imgUrl} />
        </figure>
        <div class="card-body">
          <h5 class="text-center">{props.artist?.name}</h5>
        </div>
      </a>
    } when={props.artist == null}>
      <A href="/artistpicker">
        <figure>
          <img class="w-40 h-40 object-top" src="assets/unknown.svg" />
        </figure>
        <div class="card-body ">
          <h5 class="text-center">Välj en artist</h5>
        </div>
      </A>
    </Show>

  </div>
}


async function transactArtist(type: "buy" | "sell") {
  const oldTr: Transaction[] = stagedTransactions.transactions;
  const newTr: Transaction = { type: type, artist_id: selectedArtist()?.id ?? 0 };
  setStagedTransactions({ "transactions": oldTr.concat([newTr]) });
  selectArtist(null);
}
export function ArtistPopup(props: { artist: Artist | null }) {
  const navigate = useNavigate();
  return <dialog id="ArtistPopup-modal" class="modal">
    <div class="modal-box">
      <img class="max-h-196 w-196 object-top" src={props.artist?.imgUrl} />
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
          <p class="p-2 m-2 text-center h-10 rounded-full bg-accent text-accent-content font-extrabold">
            Kostnad: {props.artist?.cost}
          </p>
          <p class="p-2 m-2 text-center h-10 rounded-full bg-secondary text-secondary-content">
            Nr {props.artist?.startNr} | Deltävling {props.artist?.heat}
          </p>
        </div>

        <div class="flex justify-end">
          <Show when={localTeam()?.includes(null) && !localTeam()?.includes(selectedArtist()?.id ?? -1)}>
            <button class="btn" onClick={() => {
              transactArtist("buy");
              navigate("/");
            }
            }>
              ✅
            </button>
          </Show>
          <Show when={localTeam()?.includes(selectedArtist()?.id ?? null)}>
            <button class="btn" onClick={() => {
              transactArtist("sell");
              navigate("/");
            }
            }>
              ❌
            </button>
          </Show>
          <Show when={false && !localTeam()?.includes(null)}>
            <button class="btn" onClick={() => transactArtist("sell")}>
              SÄLJ ARTIST
            </button>
          </Show>
        </div>

      </div>
    </div>
    <form method="dialog" class="modal-backdrop">
      <button>close</button>

    </form>
  </dialog>
}

export function EventContainer(props: { event: Event | null }) {
  return <tr>
    <td> {getArtistById(props.event?.artist ?? null)?.name}    </td>
    <td> {(rules() ?? []).find(r => r.id == props.event?.rule)?.name}    </td>
    <td> {(rules() ?? []).find(r => r.id == props.event?.rule)?.reward}  </td>
  </tr>
}

export function ArtistContainer(props: { artist: Artist }) {
  return <a onClick={() => { selectArtist(props.artist); document.getElementById('ArtistPopup-modal')?.showModal() }} class="rounded-2xl m-2 w-120 card card-side bg-primary">
    <figure>
      <img class="rounded-l-2xl w-48 h-48" src={props.artist.imgUrl ?? 'assets/unknown.svg'} />
    </figure>
    <div class="rounded-r-2xl p-4 flex flex-col justify-between w-72">
      <div class="mb-8">
        <div class="text-primary-content font-bold text-xl mb-2">{props.artist.name}</div>
        <p class="italic text-base">{props.artist.song}</p>
      </div>
      <div class="flex justify-between">
        <p class="badge text-center w-10 h-10 rounded-full bg-secondary text-secondary-content font-extrabold">
          {props.artist.cost}
        </p>
        <p class="badge text-center h-10 rounded-full bg-accent text-accent-content">
          Nr {props.artist.startNr} | Deltävling {props.artist.heat}         </p>

      </div>

    </div>
  </a>;
}
