# ProjectCoin Underwriter Module

**Introduction:**
The `underwriter::projectcoin` module is designed to facilitate the purchase of shares in a project using a custom coin type, `PROJECTCOIN`. This README provides an overview of the module, its structure, and how to interact with it.


## Introduction: projectcoin

The `underwriter::projectcoin` module enables the purchase of project shares using a specialized coin type known as `PROJECTCOIN`. 

## Module Structure: projectcoin

- `PROJECTCOIN`: This module defines a unique coin type identified as `PROJECTCOIN`. It utilizes `drop` to ensure the proper disposal of resources.
- `ProjectDetails`: A struct that stores essential project information, including an `id`, `price`, `balance`, and a `treasury` cap.

## Usage: projectcoin

### Buy Share

The `buy_share` function allows users to purchase project shares by providing payment in `Coin<SUI>`. The function ensures that the payment meets a minimum value requirement (in this case, greater than or equal to 1). The payment is then split from the provided coin, and the share is added to the project's balance. The purchased coin is also minted and transferred to the project's treasury.

## Module Initialization: projectcoin

The module is initialized through the `init` function, which is called once when the module is published. During initialization, a treasury cap is created, and the publisher gains control over minting and burning of `PROJECTCOIN`. A `ProjectDetails` object is also created, representing the project's details, and this object is shared within the network.

## Introduction: vote

The `underwriter::vote` module allows users to create and participate in polls, enabling a democratic decision-making process within a project or community. Users can create polls with specific titles and descriptions, and other users can cast their votes on these polls.

## Module Structure: vote

- `PollCreationCap`: This capability allows an owner to create a new poll. A unique ID is assigned to each poll.
- `Poll`: A struct representing an individual poll. It includes an ID, title, description, and counters for 'yes' and 'no' votes.
## Usage: vote

### Creating Polls: vote

- Users with the appropriate capability can create a new poll by providing a title and description.
- A new poll is initialized with zero 'yes' and 'no' votes.
- The created poll is shared within the network for other users to cast their votes.

### Casting Votes: vote

- Users can cast their votes on existing polls by providing a poll reference, their token (Coin), a vote choice (1 for 'yes,' 0 for 'no'), and a transaction context.
- To cast a vote, the user's token balance must be greater than zero to ensure they have enough tokens for voting.

## Initialization: vote

- The module's `init` function is called during the project's launch. It transfers the `PollCreationCap` capability to the owner to allow poll creation.
- The `init` function is typically called once and sets up the necessary structures for poll creation and voting.

