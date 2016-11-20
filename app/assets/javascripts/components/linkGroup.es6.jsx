function LinkGroup(props) {
  const links = props.links.map(link => addSlugAndName(link));

  if (props.all) {
    links.unshift({ name: `All ${props.slug}s`, slug: null })
  }

  return (
    <div className={`btn-group link-group ${props.slug}`} role="group">
      <button
        id={`link-group-${props.slug}`}
        className="btn btn-secondary dropdown-toggle"
        type="button"
        data-toggle="dropdown"
        aria-expanded="false"
        aria-haspopup="true">
        {buttonText(props.selected, props.slug, links)}
      </button>
      <div className="dropdown-menu" aria-labelledby={`link-group-${props.slug}`}>
        {R.sortBy(R.prop('name'))(links).map(link =>
          <Link linkGroupSlug={props.slug} selected={props.selected} name={link.name} slug={link.slug} key={link.slug} />
        )}
      </div>
    </div>
  );
}

function addSlugAndName(link) {
  if (!link.slug) {
    return {
      slug: link,
      name: link
    };
  }

  return link;
}

function buttonText(selected, slug, links) {
  const selectedLink = this.selectedLink(selected, links);
  if (selectedLink) {
    return selectedLink.name;
  }
  return `All ${slug}s`;
}

function selectedLink(selected, links) {
  if (selected) {
    return R.find(link => link.slug === selected)(links);
  }
  return null;
}
