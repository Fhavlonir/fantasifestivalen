import { createClient } from '@supabase/supabase-js'
const supabaseUrl = 'https://tclfopjrhhqsjmbozyya.supabase.co';
const supabaseKey = 'sb_publishable_UmnJahIC18W7J22BMu0pGg_jGhKNw4n';
export const supabase = createClient(supabaseUrl, supabaseKey);
