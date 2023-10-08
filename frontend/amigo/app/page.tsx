"use client"
import 'babel-polyfill';
import { useRouter } from 'next/navigation';
import Dashboard from './components/dashboard'
import Sidebar from './components/sidebar'





export default function Home() {
  const router = useRouter();
  const handledashboard = () => {
    router.push('/');
  };
  const handleNavigate = () => {
    router.push('/views');
  };

  return (
    <main className=" min-h-screen bg-white">
      <div className=" flex flex-row ">
      <Sidebar handleNavigate={handleNavigate} handledashboard={handledashboard}/>
      <Dashboard/>
      </div>
    </main>
  )
}
