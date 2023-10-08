"use client"
import "babel-polyfill"
import { useRouter } from "next/navigation";
import Minutespage from "../components/liveclass";
import Sidebar from "../components/sidebar";




export default function Home() {
    const router = useRouter();
    const handledashboard = () => {
        router.push('/');
      };
      const handleNavigate = () => {
        router.push('/views');
      };
  return (
   
      <div className=" flex flex-row ">
      <Sidebar handledashboard={handledashboard} handleNavigate={handleNavigate}/>
      <Minutespage/>
      </div>

  )
}
