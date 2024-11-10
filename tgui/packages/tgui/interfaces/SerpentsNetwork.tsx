import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

export const SerpentsNetwork = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window width={400} height={480}>
      <Window.Content>SerpentsNetwork</Window.Content>
    </Window>
  );
};
