import { standardErrors } from '../core/error';
import { ScopedLocalStorage } from '../lib/ScopedLocalStorage';
import { RelayEventManager } from '../relay/RelayEventManager';
import { PopUpCommunicator } from '../relay/scw/client/PopUpCommunicator';
import { EIP1193Provider } from './EIP1193Provider';

describe('EIP1193Provider', () => {
  let provider: EIP1193Provider;

  beforeEach(() => {
    provider = new EIP1193Provider({
      chainId: 1,
      jsonRpcUrl: 'fooUrl',
      overrideIsMetaMask: false,
      relayEventManager: new RelayEventManager(),
      storage: new ScopedLocalStorage('-walletlink'),
      popupCommunicator: PopUpCommunicator.shared,
    });
  });

  it('initializes correctly', () => {
    expect(provider.connected).toBe(true);
  });

  it('emits disconnect event on user initiated disconnection', () => {
    const disconnectListener = jest.fn();
    provider.on('disconnect', disconnectListener);

    provider.disconnect();

    expect(disconnectListener).toHaveBeenCalledWith({
      error: standardErrors.provider.disconnected('User initiated disconnection'),
    });
  });
});