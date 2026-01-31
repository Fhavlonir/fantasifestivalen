import { Show, Suspense, type Component } from 'solid-js';
import { A } from '@solidjs/router';
import { admin } from './utils/fantasifestivalen-globals';

const App: Component<{ children: Element }> = (props) => {

  return (
    <>
      <nav class="bg-purple-900 text-gray-200 px-4">
        <ul class="flex items-center">
          <li class="py-2 px-4">
            <A href="/" class="no-underline hover:underline">
              Ditt Lag
            </A>
          </li>
          <li class="py-2 px-4">
            <A href="/rules" class="no-underline hover:underline">
              Regler
            </A>
          </li>
          <li class="py-2 px-4">
            <A href="/events" class="no-underline hover:underline">
              Händelser
            </A>
          </li>
          <li class="py-2 px-4">
            <A href="/about" class="no-underline hover:underline">
              Om Fantasifestivalen
            </A>
          </li>
          <li class="py-2 px-4">
            <A href="/account" class="no-underline hover:underline">
              Konto
            </A>
          </li>
          <Show when={admin()}>
            <li class="py-2 px-4">
              <A href="/backend" class="no-underline hover:underline">
                Backend
              </A>
            </li>
          </Show>
        </ul>
      </nav>

      <main>
        <Suspense>{props.children}</Suspense>
      </main>
    </>
  );
};

export default App;
