export interface Artist {
  id: number;
  name: string;
  song: string;
  description: string;
  cost: number;
  imgUrl: string;
  imgCred: string;
  heat: number;
  startNr: number;
}
export interface Rule {
  id: number;
  name: string;
  reward: number;
  description: string;
}
export interface Event {
  id: number;
  artist: number;
  rule: number;
  when: number;
}
export interface Transaction {
  type: "buy" | "sell";
  artist_id: number;
};
