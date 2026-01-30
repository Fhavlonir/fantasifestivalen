import { For, Suspense } from 'solid-js';
import { EventContainer } from '../utils/fantasifestivalen-modules';
import { events } from '../utils/fantasifestivalen-globals';

export default function EventsPage() {

  return (
    <section class="p-8">
      <h1 class="text-2xl font-bold">Händelser</h1>
      <div class="flex items-center space-x-2">
        <table class="table">
          <Suspense>
            <tr>
              <For each={events()}>
                {(item, index) =>
                  <EventContainer event={item} />
                }
              </For>
            </tr>

          </Suspense>
        </table>

      </div>
    </section>
  );
}
