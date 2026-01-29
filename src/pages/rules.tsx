import { For } from 'solid-js';
import { rules } from '../utils/fantasifestivalen-globals';

export default function RulesPage() {

  return (
    <section class="bg-gray-700 text-gray-100 p-8">
      <table>
        <tr>
          <th>Namn</th>
          <th class="px-2">Belöning</th>
          <th>Kategori</th>
        </tr>
        <For each={rules()}>
          {(item, index) => (
            <tr>
              <td>{item.name}</td>
              <td class="px-2 text-right">{item.reward}</td>
              <td>{item.category}</td>
            </tr>
          )}
        </For>
      </table>
    </section>
  );
}
