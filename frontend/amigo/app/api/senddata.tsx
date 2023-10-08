// pages/api/send-data.ts

import { NextApiRequest, NextApiResponse } from 'next';

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === 'POST') {
    const { data } = req.body;
    console.log('Received Data:', data);

    // You can perform any additional processing here.

    res.status(200).json({ message: 'Data received successfully.' });
  } else {
    res.status(405).json({ message: 'Method not allowed.' });
  }
}
