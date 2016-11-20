function LinkGroups(props) {
  return (
      <div className="text-xs-center">
        <div className="btn-group link-groups" role="group" aria-label="Links">
          {props.linkGroups.map(linkGroup =>
            <LinkGroup key={linkGroup.slug}
                       slug={linkGroup.slug}
                       links={linkGroup.links}
                       all={linkGroup.all}
                       selected={linkGroup.selected}/>
          )}
        </div>
      </div>
  );
}
