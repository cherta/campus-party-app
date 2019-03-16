import gql from "graphql-tag";

export const GET_SELECTED_TALKS = gql`
  query GetSelectedTalks {
    selectedTalks @client
  }
`;

export const GET_TALKS = gql`
  query GetTalks($date: Date!) {
    talks(date: $date) {
      id
      title
      speakerName
      image
      selected @client
    }
  }
`;

export const TOGGLE_SELECTION = gql`
  mutation ToggleSelection($id: String!, $date: Date!) {
    toggleTalkSelection(id: $id, date: $date) @client {
      id
      title
      speakerName
      image
      selected @client
    }
  }
`;
