import React from 'react';

class Link extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render() {
    return (
      <a className={this.className()} href={this.href()}>{this.state.name}</a>
    );
  }

  className() {
    if (this.state.selected === this.state.slug) {
      return 'dropdown-item active';
    }
    return 'dropdown-item';
  }

  href() {
    if (this.state.slug) {
      return `?${this.state.linkGroupSlug}=${this.state.slug}`;
    }

    return `?${this.state.linkGroupSlug}=`;
  }
}

export default Link;
