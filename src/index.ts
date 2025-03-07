import { registerPlugin } from '@capacitor/core';
import type { FiuuPaymentPlugin } from './definitions';

export * from './definitions';

const FiuuPayment = registerPlugin<FiuuPaymentPlugin>('FiuuPayment');

export { FiuuPayment };
