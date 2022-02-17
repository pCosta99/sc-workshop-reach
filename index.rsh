'reach 0.1';

const Player = {
  // Fun([Typeof Arg1, Typeof Arg2], Typeof Return)
  getHand: Fun([], UInt),
  seeOutcome: Fun([UInt], Null)
};

export const main = Reach.App(() => {
  const Alice = Participant('Alice', {
    ...Player,
  });
  const Bob   = Participant('Bob', {
    ...Player,
  });
  init();

  Alice.only(() => {
    const handAlice = declassify(interact.getHand());
  });
  Alice.publish(handAlice);
  commit();

  Bob.only(() => {
    const handBob = declassify(interact.getHand());
  });
  Bob.publish(handBob);

  commit();
  const outcome = (handAlice + (4 - handBob)) % 3;

  each([Alice, Bob], () => {
    interact.seeOutcome(outcome);
  });
});