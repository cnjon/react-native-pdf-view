import * as React from 'react';

interface Props {
  style?: React.ViewStyle,
  path: string,
  src?: string,
  asset?: string,
  pageNumber?: number,
  zoom?: number,
  onLoadComplete?: () => void,
}

declare class PDFView extends React.Component<Props, any> {}

export default PDFView;