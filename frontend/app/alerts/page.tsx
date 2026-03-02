'use client';

import Link from 'next/link';
import { ArrowLeft, Bell, Calendar, CheckCheck, CheckCircle2, FileText, Home, PlayCircle, GraduationCap, User } from 'lucide-react';

export default function AlertsScreen() {
  return (
    <div className="relative flex min-h-screen w-full flex-col overflow-x-hidden max-w-md mx-auto shadow-2xl bg-background-light dark:bg-background-dark">
      <div className="sticky top-0 z-10 grid grid-cols-[3rem_1fr_3rem] items-center bg-background-light dark:bg-background-dark p-4 pb-2 border-b border-slate-200 dark:border-slate-800">
        <Link href="/" className="text-slate-900 dark:text-white flex size-12 shrink-0 items-center justify-start hover:text-primary transition-colors">
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <h2 className="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] text-center">Alerts</h2>
        <div className="flex items-center justify-end"></div>
      </div>
      
      <div className="flex-1 overflow-y-auto pb-24">
        <h3 className="text-slate-500 dark:text-slate-400 text-sm font-bold uppercase tracking-wider px-4 pb-2 pt-6">Today</h3>
        
        <div className="px-4 py-2">
          <div className="flex items-start gap-4 rounded-xl bg-white dark:bg-[#1c2230] p-4 shadow-sm border border-slate-100 dark:border-slate-800">
            <div className="flex-shrink-0 mt-1">
              <div className="flex h-10 w-10 items-center justify-center rounded-full bg-primary/10 text-primary">
                <GraduationCap className="w-5 h-5" />
              </div>
            </div>
            <div className="flex flex-1 flex-col gap-2">
              <div className="flex flex-col gap-1">
                <div className="flex justify-between items-start">
                  <p className="text-slate-900 dark:text-white text-base font-bold leading-tight">Leadership 101</p>
                  <span className="text-xs text-slate-400 dark:text-slate-500 whitespace-nowrap ml-2">2h ago</span>
                </div>
                <p className="text-slate-500 dark:text-slate-400 text-sm font-normal leading-normal">Start your journey to becoming a better leader today with our new comprehensive module.</p>
              </div>
              <div className="mt-2 flex items-center justify-between">
                <span className="inline-flex items-center rounded-md bg-primary/10 px-2 py-1 text-xs font-medium text-primary ring-1 ring-inset ring-primary/20">Course</span>
                <button className="flex items-center gap-1.5 text-xs font-semibold text-primary hover:text-primary/80 transition-colors ml-auto">
                  <CheckCircle2 className="w-4 h-4" />
                  Mark as Complete
                </button>
              </div>
            </div>
          </div>
        </div>
        
        <div className="px-4 py-2">
          <div className="flex items-start gap-4 rounded-xl bg-white dark:bg-[#1c2230] p-4 shadow-sm border border-slate-100 dark:border-slate-800 relative overflow-hidden">
            <div className="flex-shrink-0 mt-1">
              <div className="flex h-10 w-10 items-center justify-center rounded-full bg-purple-500/10 text-purple-500">
                <PlayCircle className="w-5 h-5" />
              </div>
            </div>
            <div className="flex flex-1 flex-col gap-2">
              <div className="flex flex-col gap-1">
                <div className="flex justify-between items-start">
                  <p className="text-slate-900 dark:text-white text-base font-bold leading-tight pr-4">Q4 Market Analysis</p>
                  <span className="text-xs text-slate-400 dark:text-slate-500 whitespace-nowrap ml-2">5h ago</span>
                </div>
                <p className="text-slate-500 dark:text-slate-400 text-sm font-normal leading-normal">Watch the latest breakdown of Q4 trends by our chief analyst.</p>
              </div>
              <div className="mt-2 flex items-center justify-between">
                <span className="inline-flex items-center rounded-md bg-purple-500/10 px-2 py-1 text-xs font-medium text-purple-500 ring-1 ring-inset ring-purple-500/20">Video</span>
                <button className="flex items-center gap-1.5 text-xs font-semibold text-primary hover:text-primary/80 transition-colors ml-auto">
                  <CheckCircle2 className="w-4 h-4" />
                  Mark as Complete
                </button>
              </div>
            </div>
          </div>
        </div>
        
        <h3 className="text-slate-500 dark:text-slate-400 text-sm font-bold uppercase tracking-wider px-4 pb-2 pt-6">Yesterday</h3>
        
        <div className="px-4 py-2">
          <div className="flex items-start gap-4 rounded-xl bg-white dark:bg-[#1c2230] p-4 shadow-sm border border-slate-100 dark:border-slate-800 opacity-80">
            <div className="flex-shrink-0 mt-1">
              <div className="flex h-10 w-10 items-center justify-center rounded-full bg-green-500/10 text-green-500">
                <FileText className="w-5 h-5" />
              </div>
            </div>
            <div className="flex flex-1 flex-col gap-2">
              <div className="flex flex-col gap-1">
                <div className="flex justify-between items-start">
                  <p className="text-slate-900 dark:text-white text-base font-bold leading-tight">Remote Work Tips</p>
                  <span className="text-xs text-slate-400 dark:text-slate-500 whitespace-nowrap ml-2">1d ago</span>
                </div>
                <p className="text-slate-500 dark:text-slate-400 text-sm font-normal leading-normal">Top 10 strategies to stay productive while working from home.</p>
              </div>
              <div className="mt-2 flex items-center justify-between">
                <span className="inline-flex items-center rounded-md bg-green-500/10 px-2 py-1 text-xs font-medium text-green-500 ring-1 ring-inset ring-green-500/20">Article</span>
                <span className="flex items-center gap-1.5 text-xs font-medium text-green-500 ml-auto">
                  <CheckCheck className="w-4 h-4" />
                  Completed
                </span>
              </div>
            </div>
          </div>
        </div>
        
        <div className="h-10"></div>
      </div>
      
      <div className="fixed bottom-0 w-full max-w-md border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-[#1c2230] px-4 pb-6 pt-2 z-20">
        <div className="flex gap-2 justify-between">
          <Link href="/" className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors">
            <div className="flex h-8 items-center justify-center">
              <Home className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">Home</p>
          </Link>
          <Link href="#" className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors">
            <div className="flex h-8 items-center justify-center">
              <Calendar className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">Plan</p>
          </Link>
          <Link href="/alerts" className="flex flex-1 flex-col items-center justify-end gap-1 rounded-full text-primary">
            <div className="flex h-8 items-center justify-center relative">
              <Bell className="w-6 h-6 fill-current" />
              <span className="absolute top-1 right-0.5 h-2 w-2 rounded-full bg-red-500 border border-white dark:border-[#1c2230]"></span>
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">Alerts</p>
          </Link>
          <Link href="#" className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors">
            <div className="flex h-8 items-center justify-center">
              <User className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">Profile</p>
          </Link>
        </div>
      </div>
    </div>
  );
}
