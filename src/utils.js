export const groupBy = (items, key) => items.reduce(
    (result, item) => ({
      ...result,
      [item[key]]: [
        ...(result[item[key]] || []),
        item,
      ],
    }), 
    {},
  );

  export const dateFormattedFromISO = (date) => {
    if (!date) return null
    const [year, month, day] = date.split('-')
    return `${day}/${month}/${year}`
  }