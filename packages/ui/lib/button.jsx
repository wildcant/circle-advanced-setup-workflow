/* eslint-disable react/prop-types */
export function Button({ children, ...props }) {
  return (
    <button {...props} style={{ background: 'red' }}>
      {children}
    </button>
  )
}
