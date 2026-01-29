import { user, supabase } from '../utils/fantasifestivalen-globals';
import { createSignal, onMount, Show } from 'solid-js';

const [email, setEmail] = createSignal("");
const [password, setPassword] = createSignal("");
const [userinfo, setUserinfo] = createSignal("");
const [existingAccount, setExistingAccount] = createSignal(false);

function register() {
  supabase.auth.signUp({
    email: email(),
    password: password()
  });
}

function login() {
  supabase.auth.signInWithPassword({
    email: email(),
    password: password()
  });
}
function logout() {
  supabase.auth.signOut();
}

async function displayuser() {
  setUserinfo(user()?.email ?? "");
};
export default function AccountPage() {
  onMount(() => {
    displayuser();
  });
  return <section class="bg-gray-100 text-gray-700 p-8">
    <h1 class="text-2xl font-bold">Konto</h1>
    <Show when={userinfo().length < 1}
      fallback={
        <div>
          <p>
            {userinfo()}
          </p>
          <button class="btn" onClick={logout}>Logga ut</button>
        </div>
      }
    >
      <Show when={existingAccount()}>
        <form on:submit={(e) => {
          e.preventDefault();
          login();
          setEmail("");
        }}>
          <div class="field-block">
            <input
              class="input"
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
              class="input"
              name="password"
              type="password"
              placeholder="Lösenord"
              value={password()}
              onInput={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button class="btn" type="submit">Logga in</button>
        </form>
        <br />
        Har du inget konto?
        <br />
        <button class="btn" onClick={() => { setExistingAccount(false) }}>Registrera dig här</button>
      </Show>
      <Show when={!existingAccount()}>
        <form on:submit={(e) => {
          e.preventDefault();
          register();
          setEmail("");
        }}>
          <div class="field-block">
            <input
              class="input"
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
              class="input"
              name="password"
              type="password"
              placeholder="Lösenord"
              value={password()}
              onInput={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <button class="btn" type="submit">Registrera dig</button>
        </form>
        <br />
        Har du redan ett konto?
        <br />
        <button class="btn" onClick={() => { setExistingAccount(true) }}>Logga in här</button>
      </Show>

    </Show>
  </section>
}
