Results.EventCategoryLinks =function EventCategoryLinks(props) {
  if (props.eventCategories.length < 2) {
    return null;
  }

  return (
    <table>
      <tbody>
        {eventCategoryRows(props).map(row => <Results.EventCategoryLinkRow row={row} />)}
      </tbody>
    </table>
  );
}

function eventCategoryRows(props) {
  const rows = [];
  const sortedEventCategories = props.eventCategories.sort();
  const firstHalf = sortedEventCategories.slice(0, (sortedEventCategories.length / 2.0 + 0.5));

  firstHalf.forEach((eventCategory, index) => {
    const rightEventCategory = sortedEventCategories[firstHalf.length + index];
    if (rightEventCategory) {
      rows.push([eventCategory, rightEventCategory])
    } else {
      rows.push([eventCategory])
    }
  });

  return rows;
}
