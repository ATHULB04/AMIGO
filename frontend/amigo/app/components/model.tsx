import React from 'react';

interface MyObject {
  isvisible: boolean;
  onClose: () => void;
  children: React.ReactNode;
  // other properties
}

const Model = ({ isvisible, onClose ,children}: MyObject) => {
  if (!isvisible) return null;

  const handleClose = (e: React.MouseEvent<HTMLDivElement>) => {
    const target = e.target as HTMLDivElement; // Cast e.target to HTMLDivElement
    if (target.id === 'wrapper') onClose();
  };

  return (
    <div className='z-10 fixed inset-0 bg-black bg-opacity-25 backdrop-blur-sm flex justify-center items-center ' id='wrapper' onClick={handleClose}>
      <div className='w-[600px]'>
        <button className='text-white text-xl place-self-end' onClick={() => onClose()}>X</button>
        <div className='bg-white p-2 rounded'>
          {children}
        </div>
      </div>
    </div>
  );
};

export default Model;
