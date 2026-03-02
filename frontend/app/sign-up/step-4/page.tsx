"use client";

import Link from "next/link";
import { ArrowLeft, Clock, MapPin } from "lucide-react";
import { useState } from "react";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";

export default function SignupStep4() {
  const [fromTime, setFromTime] = useState<Date | null>(() => {
    const d = new Date();
    d.setHours(0, 0, 0, 0);
    return d;
  });
  const [toTime, setToTime] = useState<Date | null>(() => {
    const d = new Date();
    d.setHours(0, 0, 0, 0);
    return d;
  });
  const [location, setLocation] = useState("");

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      <div className="flex items-center p-4 pb-2 justify-between z-10">
        <Link
          href="/sign-up/step-3"
          className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors"
        >
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <div className="text-slate-900 dark:text-slate-100 font-semibold text-sm">
          Step 4 of 4
        </div>
        <div className="w-10"></div>
      </div>

      <div className="px-6 pb-2 z-10">
        <div className="w-full bg-slate-200 dark:bg-slate-800 rounded-full h-1.5">
          <div className="bg-primary h-1.5 rounded-full w-full"></div>
        </div>
      </div>

      <div className="px-6 pt-4 pb-4 z-10">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">
          Time & Location
        </h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">
          Tell us when and where you prefer to learn so we can fit Recom24 into
          your routine.
        </p>
      </div>

      <form className="flex flex-col gap-6 px-6 py-2 mt-2 flex-grow z-10">
        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-3 flex items-center gap-2">
            <Clock className="text-primary w-5 h-5" />
            Preferred Learning Time
          </label>
          <div className="grid grid-cols-2 gap-4 mb-4">
            <div className="flex flex-col items-center">
              <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-1">
                Start Time
              </label>
              <DatePicker
                selected={fromTime}
                onChange={(date: Date | null) => setFromTime(date)}
                showTimeSelect
                showTimeSelectOnly
                timeIntervals={15}
                timeCaption="Time"
                dateFormat="HH:mm"
                className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-3 text-sm transition-all outline-none"
              />
            </div>
            <div className="flex flex-col items-center">
              <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-1">
                End Time
              </label>
              <DatePicker
                selected={toTime}
                onChange={(date: Date | null) => setToTime(date)}
                showTimeSelect
                showTimeSelectOnly
                timeIntervals={15}
                timeCaption="Time"
                dateFormat="HH:mm"
                className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-3 text-sm transition-all outline-none"
              />
            </div>
          </div>
        </div>

        <div className="h-px w-full bg-slate-200 dark:bg-slate-800 my-2"></div>

        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-4 flex items-center gap-2">
            <MapPin className="text-primary w-5 h-5" />
            Location
          </label>

          <div className="flex flex-col w-full mb-4">
            <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">
              City or Region
            </label>
            <input
              className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none"
              placeholder="e.g. San Francisco, CA"
              type="text"
              value={location}
              onChange={(e) => setLocation(e.target.value)}
            />
          </div>
        </div>

        <div className="mt-auto pt-8 mb-2">
          <Link
            href="/alerts"
            className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]"
          >
            Complete Onboarding
          </Link>
        </div>
      </form>

      <div className="px-6 pb-12 text-center z-10">
        <Link
          href="/alerts"
          className="w-full bg-white dark:bg-slate-800 hover:bg-slate-50 dark:hover:bg-slate-700 border border-slate-200 dark:border-slate-700 hover:cursor-pointer text-slate-900 dark:text-white font-bold h-14 rounded-xl shadow-lg shadow-white/20 dark:shadow-slate-800/20 flex items-center justify-center transition-all active:scale-[0.98]"
        >
          Skip for now
        </Link>
      </div>

      <div className="fixed -top-24 -right-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl pointer-events-none"></div>
      <div className="fixed -bottom-24 -left-24 w-64 h-64 bg-primary/10 rounded-full blur-3xl pointer-events-none"></div>
    </div>
  );
}
