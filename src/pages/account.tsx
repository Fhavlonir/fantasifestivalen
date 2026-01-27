import { supabase } from '../utils/supabase';
import { createSignal, onMount, Show } from 'solid-js';

const [email, setEmail] = createSignal("");
const [userinfo, setUserinfo] = createSignal("");


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
      } else {
        window.history.replaceState({}, document.title, "/");
      }
    });
  }
}
function login() {
  supabase.auth.signInWithOtp({
    email: email(),
    options: {
      emailRedirectTo: window.location.origin + "/account",
    }
  });
}
function logout() {
  supabase.auth.signOut();
}

async function displayuser() {
  setUserinfo((await supabase.auth.getUser())?.data?.user?.email ?? "");
};
export default function AccountPage() {
  onMount(() => {
    detecttoken();
    displayuser();
  });
  console.log(userinfo());
  return <section class="bg-gray-100 text-gray-700 p-8">
    <h1 class="text-2xl font-bold">Konto</h1>
    <Show when={userinfo().length < 1}
      fallback={
        <div>
          <p>
            {userinfo()}
          </p>
          <button class="" onClick={logout}>Logga ut</button>
        </div>
      }
    >
      <form on:submit={(e) => {
        e.preventDefault();
        login();
        setEmail("");
      }}>
        <div class="field-block">
          <input
            name="email"
            type="email"
            placeholder="E-post"
            value={email()}
            onInput={(e) => setEmail(e.target.value)}
            required
          />
        </div>
        <button class="btn" type="submit">Logga in</button>
      </form>
    </Show>
  </section>
}
