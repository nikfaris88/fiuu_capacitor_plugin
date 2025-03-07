import { registerPlugin } from '@capacitor/core';
import type { FiuuPaymentPluginPlugin } from './definitions';

export * from './definitions';

const FiuuPaymentPlugin = registerPlugin<FiuuPaymentPluginPlugin>('FiuuPayment');

export { FiuuPaymentPlugin };
