import { registerPlugin } from '@capacitor/core';

const FiuuPaymentPlugin = registerPlugin('FiuuPaymentPlugin', {
  ios: {
    name: 'FiuuPaymentPlugin',
    platforms: ['ios'],
  },
});

export { FiuuPaymentPlugin };
export type { FiuuPaymentPlugin as FiuuPaymentPluginType };
