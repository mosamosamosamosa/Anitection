import cat_calico_head from '../assets/animals/cat/calico/head.png';
import cat_calico_body from '../assets/animals/cat/calico/body.png';
import cat_calico_sitting from '../assets/animals/cat/calico/sitting.png';
import cat_calico_tail from '../assets/animals/cat/calico/tail.png';

import cat_gray_solid_head from '../assets/animals/cat/gray_solid/head.png';
import cat_gray_solid_body from '../assets/animals/cat/gray_solid/body.png';
import cat_gray_solid_tail from '../assets/animals/cat/gray_solid/tail.png';

import dog_shiba_inu_head from '../assets/animals/shiba_inu/head.png';
import dog_shiba_inu_sitting from '../assets/animals/shiba_inu/sitting.png';
import dog_shiba_inu_tail from '../assets/animals/shiba_inu/tail.png';

import dog_shih_tzu_head from '../assets/animals/shih_tzu/head.png';
import dog_shih_tzu_sitting from '../assets/animals/shih_tzu/sitting.png';
import dog_shih_tzu_tail from '../assets/animals/shih_tzu/tail.png';

import default_head from '../assets/animals/default/head.png';
import default_body from '../assets/animals/default/body.png';
import default_sitting from '../assets/animals/default/sitting.png';
import default_tail from '../assets/animals/default/tail.png';

type AnimalImg = {
  head: string;
  body: string;
  sitting: string;
  tail: string;
};

const cat_calico: AnimalImg = {
  head: cat_calico_head,
  body: cat_calico_body,
  sitting: cat_calico_sitting,
  tail: cat_calico_tail,
};

const cat_gray_solid: AnimalImg = {
  head: cat_gray_solid_head,
  body: cat_gray_solid_body,
  sitting: default_sitting,
  tail: cat_gray_solid_tail,
};

const dog_shiba_inu: AnimalImg = {
  head: dog_shiba_inu_head,
  body: default_body,
  sitting: dog_shiba_inu_sitting,
  tail: dog_shiba_inu_tail,
};

const dog_shih_tzu: AnimalImg = {
  head: dog_shih_tzu_head,
  body: default_body,
  sitting: dog_shih_tzu_sitting,
  tail: dog_shih_tzu_tail,
};

const default_img: AnimalImg = {
  head: default_head,
  body: default_body,
  sitting: default_sitting,
  tail: default_tail,
};

export const getAnimalImg = (pedigree: string, pattern: string): AnimalImg => {
  // dog
  switch (pedigree) {
    case '柴犬':
      return dog_shiba_inu;
    case 'シーズー':
      return dog_shih_tzu;
    case 'ネコ':
      switch (pattern) {
        case 'ミケ':
          return cat_calico;
        case 'グレートラ':
          return cat_gray_solid;
      }
      break;
    default:
      return default_img;
  }
  return default_img;
};
