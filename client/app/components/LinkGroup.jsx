import Link from './Link';
import R from 'ramda';
import React from 'react';

class LinkGroup extends React.Component {
  constructor(props) {
    super(props);
    this.state = {...props};
  }

  render() {
    const links = this.state.links.map(link => this.addSlugAndName(link));

    if (this.state.all) {
      links.unshift({ name: `All ${this.state.slug}s`, slug: null })
    }

    return (
      <div className={`btn-group link-group ${this.state.slug}`} role="group">
        <button
          id={`link-group-${this.state.slug}`}
          className="btn btn-secondary dropdown-toggle"
          type="button"
          data-toggle="dropdown"
          aria-expanded="false"
          aria-haspopup="true">
          {this.buttonText(this.state.selected, this.state.slug, links)}
        </button>
        <div className="dropdown-menu" aria-labelledby={`link-group-${this.state.slug}`}>
          {R.sortBy(R.prop('name'))(links).map(link =>
            <Link linkGroupSlug={this.state.slug} selected={this.state.selected} name={link.name} slug={link.slug} key={link.slug} />
          )}
        </div>
      </div>
    );
  }

  addSlugAndName(link) {
    if (!link.slug) {
      return {
        slug: link,
        name: link
      };
    }

    return link;
  }

  buttonText(selected, slug, links) {
    const selectedLink = this.selectedLink(selected, links);
    if (selectedLink) {
      return selectedLink.name;
    }
    return `All ${slug}s`;
  }

  selectedLink(selected, links) {
    if (selected) {
      return R.find(link => link.slug === selected)(links);
    }
    return null;
  }
}

export default LinkGroup;
