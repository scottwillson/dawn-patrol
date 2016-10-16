function CategoryLinks(props) {
  if (props.categories.length < 2) {
    return null;
  }

  return (
    <table>
      <tbody>
        {categoryRows(props).map(row => <CategoryLinkRow row={row} />)}
      </tbody>
    </table>
  );
}

function categoryRows(props) {
  const rows = [];
  const sortedCategories = props.categories.sort();
  const firstHalf = sortedCategories.slice(0, (sortedCategories.length / 2.0 + 0.5));

  firstHalf.forEach((category, index) => {
    const rightCategory = sortedCategories[firstHalf.length + index];
    if (rightCategory) {
      rows.push([category, rightCategory])
    } else {
      rows.push([category])
    }
  });

  return rows;
}
