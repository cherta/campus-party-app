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
    }
  }
`;
