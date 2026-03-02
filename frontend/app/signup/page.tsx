'use client';

import Link from 'next/link';
import { ArrowLeft, Eye, EyeOff } from 'lucide-react';
import { useState } from 'react';

export default function SignupStep1() {
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  const [profession, setProfession] = useState('Designer');

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      <div className="flex items-center p-4 pb-2 justify-between z-10">
        <Link href="/" className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors">
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <div className="text-slate-900 dark:text-slate-100 font-semibold text-sm">Step 1 of 4</div>
        <div className="w-10"></div>
      </div>
      
      <div className="px-6 pb-2 z-10">
        <div className="w-full bg-slate-200 dark:bg-slate-800 rounded-full h-1.5">
          <div className="bg-primary h-1.5 rounded-full w-1/4"></div>
        </div>
      </div>
      
      <div className="px-6 pt-4 pb-4 z-10">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">Create Account</h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">Let&apos;s get you set up with Recom24</p>
      </div>
      
      <form className="flex flex-col gap-4 px-6 py-2 mt-2 z-10 flex-grow">
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Full Name</label>
          <input className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none" placeholder="Enter your name" type="text" />
        </div>
        
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Email Address</label>
          <input className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none" placeholder="Enter your email" type="email" />
        </div>
        
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Profession</label>
          <div className="flex flex-wrap gap-2 mb-3">
            {['Designer', 'Developer', 'Manager'].map((prof) => (
              <button 
                key={prof}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${profession === prof ? 'bg-primary/10 text-primary border border-primary/20 hover:bg-primary/20' : 'bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 hover:border-primary/50 hover:text-primary'}`} 
                type="button"
                onClick={() => setProfession(prof)}
              >
                {prof}
              </button>
            ))}
          </div>
          <input className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none" placeholder="Other (please specify)" type="text" />
        </div>
        
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Password</label>
          <div className="relative flex w-full items-stretch">
            <input className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base transition-all outline-none" type={showPassword ? "text" : "password"} />
            <button className="absolute right-0 h-12 px-4 flex items-center justify-center text-slate-400 hover:text-primary transition-colors" type="button" onClick={() => setShowPassword(!showPassword)}>
              {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
            </button>
          </div>
        </div>
        
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">Confirm Password</label>
          <div className="relative flex w-full items-stretch">
            <input className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-12 px-4 text-base transition-all outline-none" type={showConfirmPassword ? "text" : "password"} />
            <button className="absolute right-0 h-12 px-4 flex items-center justify-center text-slate-400 hover:text-primary transition-colors" type="button" onClick={() => setShowConfirmPassword(!showConfirmPassword)}>
              {showConfirmPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
            </button>
          </div>
        </div>
        
        <div className="mt-8 mb-6">
          <Link href="/signup/goals" className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]">
            Next
          </Link>
        </div>
      </form>
      
      <div className="mt-auto px-6 pb-12 text-center z-10">
        <p className="text-slate-500 dark:text-slate-400 text-sm">
          Already have an account? 
          <Link className="text-primary font-semibold hover:underline ml-1" href="/login">Login here</Link>
        </p>
      </div>
      
      <div className="fixed -top-24 -right-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl pointer-events-none"></div>
      <div className="fixed -bottom-24 -left-24 w-64 h-64 bg-primary/10 rounded-full blur-3xl pointer-events-none"></div>
    </div>
  );
}
