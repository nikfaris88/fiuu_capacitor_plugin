import { registerPlugin } from '@capacitor/core';

const FiuuPaymentPlugin = registerPlugin('FiuuPaymentPlugin', {
  android: {
    name: 'FiuuPaymentPlugin',
    platforms: ['android'],
  },
});

export { FiuuPaymentPlugin };
export type { FiuuPaymentPlugin as FiuuPaymentPluginType };
