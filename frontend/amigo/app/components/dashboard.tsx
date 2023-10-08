"use client"
import React, { useEffect } from "react";
import { useListVals } from "react-firebase-hooks/database";
import db from "../firebase";
import { collection, doc, getDoc, getDocs, query, updateDoc, where } from "firebase/firestore";
import { ref, set } from "firebase/database";
import Swal from 'sweetalert2';
import { Button, ButtonGroup } from "@nextui-org/react";
import { useState } from "react";
import Link from "next/link";
import Image from "next/image";
import { Console } from "console";
type StatusesKeys = "open" | string;



interface MarkerData {
    id: string;
    address: string;
    lat: number;
    lng: number;
}

const containerStyle = {
    height: "400px",
    width: "100%",
    borderRadius: "10px",
};





export default function Dashboard() {
    const [StudentsDoc1, setStudentsDoc1] = useState<
        {
            id: any;
            name: string;
            RollNo: string;
            attended: string;
            phone: string;
            // ... Other properties
        }[]
    >([]); // Initialize as an empty array


    const [classes, setClasses] = useState("ECB");

    useEffect(() => {
        fetchDocs(); // Initial fetch
    }, []);

    useEffect(() => {
        // When classes change, fetchDocs again
        fetchDocs();
    }, [classes]);

    console.log('Formatted Calls 1:', StudentsDoc1);

    // Your JSX and component code here

    // ...

    const handleStatus = async () => {
        try {
            const colRef = doc(db, "students", classes);
            const snapshots = await getDoc(colRef);
            const docData = snapshots.data();

            if (docData) {
                const StudentDix = Object.keys(docData).map((key) => (
                    docData[key].absent ? {
                        id: key,
                        name: docData[key].Name,
                        RollNo: docData[key].Rollno,
                        attended: docData[key].attended,
                        phone: docData[key].phone,

                        // ... Include other properties here
                    } :
                        {
                            id: "",
                            name: "",
                            RollNo: "",
                            attended: "",
                            phone: ""

                        }
                )
                );
                setStudentsDoc1(StudentDix);// Update state with the formatted data

            }
        } catch (error) {
            console.error("Error fetching ECB data:", error);
        }
    };

    const presentStatus = async () => {
        try {
            const colRef = doc(db, "students", classes);
            const snapshots = await getDoc(colRef);
            const docData = snapshots.data();

            if (docData) {
                const StudentDix = Object.keys(docData).map((key) => (
                    docData[key].absent ? {
                        id: "",
                        name: "",
                        RollNo: "",
                        attended: "",
                        phone: ""
                        // ... Include other properties here
                    } :
                        {

                            id: key,
                            name: docData[key].Name,
                            RollNo: docData[key].Rollno,
                            attended: docData[key].attended,
                            phone: docData[key].phone,


                        }
                )
                );
                setStudentsDoc1(StudentDix);// Update state with the formatted data

            }
        } catch (error) {
            console.error("Error fetching ECB data:", error);
        }
    };



    const fetchDocs = async () => {
        try {
            const colRef = doc(db, "students", classes);
            const snapshots = await getDoc(colRef);
            const docData = snapshots.data();

            if (docData) {
                const StudentDix = Object.keys(docData).map((key) => (
                    {
                        id: key,
                        name: docData[key].Name,
                        RollNo: docData[key].Rollno,
                        attended: docData[key].attended,
                        phone: docData[key].phone,

                        // ... Include other properties here
                    }
                )
                );
                setStudentsDoc1(StudentDix); // Update state with the formatted data
            }
        } catch (error) {
            console.error("Error fetching ECB data:", error);
        }
    };

    const [selectedOrderIndex, setSelectedOrderIndex] = useState(1);
    const [showOrderDetails, setShowOrderDetails] = useState(false);

    const [infoWindowData, setInfoWindowData] = React.useState<MarkerData | null>(
        null
    );
    const [isOpen, setIsOpen] = React.useState(false);

    const handleMarkerClick = (marker: MarkerData) => {
        setInfoWindowData(marker);
        setIsOpen(true);
    };

    return (
        <div className="flex min-h-screen w-full">

            <div
                className="flex w-full flex-col bg-[#eef7ff] sm:w-64 m-4 rounded-3xl p-2"
                style={{ flex: 3 }}
            >
                <div className="py-12 bg-slate-100 sm:py-16 lg:py-7 w-full">
                    <div className="bg-white w-fit p-4 mx-auto m-5 flex rounded-xl">
                        <button
                            type="button"
                            onClick={() => {
                                setClasses("ECB");
                                console.log(classes);
                            }}
                            className={`py-2.5 px-5 mr-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200  focus:text-blue-700 ${classes === "ECB" ? 'active' : ''}`}
                        >
                            ECB
                        </button>
                        <button
                            type="button"
                            onClick={() => {
                                setClasses("CSB");
                                console.log(classes);
                            }}
                            className={`py-2.5 px-5 mr-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200  focus:text-blue-700 ${classes === "CSB" ? 'active' : ''}`}
                        >
                            CSB
                        </button>
                        <button
                            type="button"
                            onClick={() => {
                                setClasses("EB");
                                console.log(classes);
                            }}
                            className={`py-2.5 px-5 mr-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200  focus:text-blue-700 ${classes === "EB" ? 'active' : ''}`}
                        >
                            EB
                        </button>
                        <button
                            type="button"
                            onClick={() => {
                                setClasses("CSA");
                                console.log(classes);
                            }}
                            className={`py-2.5 px-5 mr-2 mb-2 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-200 focus:text-blue-700 ${classes === "CSA" ? 'active' : ''}`}
                        >
                            CSA
                        </button>
                    </div>

                    <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
                        <div className="grid max-w-5xl grid-cols-1 gap-12 mx-auto sm:grid-cols-2 lg:grid-cols-3">

                            <div onClick={() => { fetchDocs() }} className="bg-white  border hover:shadow-xl scale-105 cursor-pointer  border-blue-200 rounded-xl">
                                <div className="px-5 py-4">
                                    <p className="text-sm font-medium tracking-wider text-gray-700 uppercase">
                                        <Image width="32" height="32" src="https://img.icons8.com/ultraviolet/40/class.png" alt="tasks" />{" "}
                                        Students{" "}
                                    </p>
                                    <div className="flex items-center justify-between mt-3">
                                        <p className="text-xl font-bold text-gray-900 ml-3">
                                            7
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div onClick={() => { presentStatus() }} className="bg-white border hover:shadow-xl cursor-pointer  border-blue-200 rounded-xl">
                                <div className="px-5 py-4">
                                    <p className="text-sm font-medium tracking-wider text-gray-700 uppercase">
                                        <Image width="32" height="32"
                                            src="https://img.icons8.com/pulsar-color/48/raise-a-hand-to-answer.png"
                                            alt="external-ongoing-delivery-duotone-others-ghozy-muhtarom"
                                        />{" "}
                                        Present{" "}
                                    </p>
                                    <div className="flex items-center justify-between mt-3">
                                        <p className="text-xl font-bold text-gray-900 ml-3">
                                            {" "}
                                            5
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <div onClick={() => { handleStatus() }} className="bg-white border hover:shadow-xl cursor-pointer border-blue-200 rounded-xl">
                                <div className="px-5 py-4">
                                    <p className="text-sm font-medium tracking-wider text-gray-700 uppercase">
                                        <Image width="32" height="32" src="https://img.icons8.com/color/48/attendance-mark.png" alt="ok--v1" />{" "}
                                        Absentees{" "}
                                    </p>
                                    <div className="flex items-center justify-between mt-3">
                                        <p className="text-xl font-bold text-gray-900 ml-3">
                                            {" "}
                                            2
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div className=" mx-auto  w-11/12">
                    <div className="py-12 bg-white sm:py-16 lg:py-2 rounded-3xl">
                        <div className="sm:px-6 ">
                            <div className="flex flex-col mt-4 lg:mt-8">
                                <div className=" -my-2 overflow-x-auto sm:-mx-6 ">
                                    <div className="py-2 ">
                                        <div className="grid grid-cols-4 gap-x-3.5">
                                            <div className="py-3.5 pl-4  pr-3 text-left text-sm whitespace-nowrap font-medium text-gray-500">
                                                <div className="flex items-center">Roll No</div>
                                            </div>

                                            <div className="py-3.5  text-left text-sm  whitespace-nowrap font-medium text-gray-500">
                                                <div className="flex items-center">Student Name </div>
                                            </div>
                                            <div className="py-3.5 px-3 text-left text-sm whitespace-nowrap font-medium text-gray-500">
                                                <div className="flex items-center">Classes Attended</div>
                                            </div>

                                            <div className="py-3.5 mx-auto text-left text-sm whitespace-nowrap font-medium text-gray-500">
                                                <div className="flex items-center">Mobile NO.</div>
                                            </div>
                                        </div>
                                        {StudentsDoc1.map((call, index) => (
                                            <div key={call.name}>
                                                <div className="divide-y pl-10 divide-gray-200">
                                                    <div
                                                        className="grid grid-cols-4 gap-x-0.5"
                                                        key={call.id}

                                                    >
                                                        <div className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 whitespace-nowrap">
                                                            {index + 1}
                                                        </div>
                                                        <div className=" py-4 col-span-1 text-sm font-medium text-gray-900 whitespace-nowrap">
                                                            {call.name}
                                                        </div>
                                                        <div className="px-10 py-4 col-span-1 text-sm font-medium text-gray-900 whitespace-nowrap">
                                                            {call.attended}{""}
                                                        </div>{" "}

                                                        <div className=" py-4 mx-auto text-sm font-bold text-gray-900 whitespace-nowrap">
                                                            <a href={`tel:${call.phone}`}>
                                                                <Image
                                                                    className="inline-block mr-2 "
                                                                    width="30"
                                                                    height="30"
                                                                    src="https://img.icons8.com/color/48/apple-phone.png"
                                                                    alt="apple-phone"
                                                                />
                                                                {call.phone}
                                                            </a>
                                                        </div>



                                                    </div>
                                                </div>


                                            </div>
                                        ))}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}