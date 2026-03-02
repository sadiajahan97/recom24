'use client';

import Link from 'next/link';
import { ArrowLeft, Clock, MapPin } from 'lucide-react';
import { useState } from 'react';

export default function SignupStep4() {
  const [selectedTimes, setSelectedTimes] = useState<string[]>(['Evening', 'Weekends']);
  const [selectedHours, setSelectedHours] = useState<string>('3-5 hrs/wk');
  const [location, setLocation] = useState('');

  const toggleTime = (time: string) => {
    setSelectedTimes(prev => 
      prev.includes(time) ? prev.filter(t => t !== time) : [...prev, time]
    );
  };

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      <div className="flex items-center p-4 pb-2 justify-between z-10">
        <Link href="/signup/interests" className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors">
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <div className="text-slate-900 dark:text-slate-100 font-semibold text-sm">Step 4 of 4</div>
        <div className="w-10"></div>
      </div>
      
      <div className="px-6 pb-2 z-10">
        <div className="w-full bg-slate-200 dark:bg-slate-800 rounded-full h-1.5">
          <div className="bg-primary h-1.5 rounded-full w-full"></div>
        </div>
      </div>
      
      <div className="px-6 pt-4 pb-4 z-10">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">Availability & Location</h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">When and where do you want to learn?</p>
      </div>
      
      <form className="flex flex-col gap-6 px-6 py-2 mt-2 flex-grow z-10">
        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-3 flex items-center gap-2">
            <Clock className="text-primary w-5 h-5" />
            Time Availability
          </label>
          <div className="flex flex-wrap gap-2.5 mb-4">
            {['Morning', 'Afternoon', 'Evening', 'Weekends'].map((time) => {
              const isChecked = selectedTimes.includes(time);
              return (
                <label key={time} className="cursor-pointer group">
                  <input 
                    className="peer sr-only" 
                    type="checkbox" 
                    checked={isChecked}
                    onChange={() => toggleTime(time)}
                  />
                  <div className={`px-4 py-2 rounded-xl text-sm transition-all ${isChecked ? 'bg-primary/10 text-primary border-primary font-semibold border' : 'bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 font-medium hover:border-primary/50 hover:text-primary'}`}>
                    {time}
                  </div>
                </label>
              );
            })}
          </div>
          
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Weekly Commitment</label>
          <div className="flex flex-wrap gap-2.5">
            {['1-2 hrs/wk', '3-5 hrs/wk', '5+ hrs/wk'].map((hours) => {
              const isChecked = selectedHours === hours;
              return (
                <button 
                  key={hours}
                  type="button"
                  onClick={() => setSelectedHours(hours)}
                  className={`px-4 py-2 rounded-xl text-sm transition-all ${isChecked ? 'bg-primary/10 text-primary border-primary font-semibold border' : 'bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 font-medium hover:border-primary/50 hover:text-primary'}`}
                >
                  {hours}
                </button>
              );
            })}
          </div>
        </div>
        
        <div className="h-px w-full bg-slate-200 dark:bg-slate-800 my-2"></div>
        
        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-4 flex items-center gap-2">
            <MapPin className="text-primary w-5 h-5" />
            Location
          </label>
          
          <div className="flex flex-col w-full mb-4">
            <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">City or Region</label>
            <input 
              className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none" 
              placeholder="e.g. San Francisco, CA" 
              type="text" 
              value={location}
              onChange={(e) => setLocation(e.target.value)}
            />
          </div>
        </div>
        
        <div className="mt-auto pt-8 mb-6">
          <Link href="/alerts" className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]">
            Complete Setup
          </Link>
        </div>
      </form>
      
      <div className="px-6 pb-12 text-center z-10">
        <button className="text-slate-500 dark:text-slate-400 text-sm font-medium hover:text-primary transition-colors">
          Skip for now
        </button>
      </div>
      
      <div className="fixed -top-24 -right-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl pointer-events-none"></div>
      <div className="fixed -bottom-24 -left-24 w-64 h-64 bg-primary/10 rounded-full blur-3xl pointer-events-none"></div>
    </div>
  );
}
