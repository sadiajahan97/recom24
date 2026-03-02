"use client";

import Link from "next/link";
import { ArrowLeft, Briefcase, Smile } from "lucide-react";
import { useState } from "react";

export default function SignupStep2() {
  const [selectedCareerGoals, setSelectedCareerGoals] = useState<string[]>([]);
  const [selectedLifestyleGoals, setSelectedLifestyleGoals] = useState<
    string[]
  >([]);

  const toggleCareerGoal = (goal: string) => {
    setSelectedCareerGoals((prev) =>
      prev.includes(goal) ? prev.filter((g) => g !== goal) : [...prev, goal],
    );
  };

  const toggleLifestyleGoal = (goal: string) => {
    setSelectedLifestyleGoals((prev) =>
      prev.includes(goal) ? prev.filter((g) => g !== goal) : [...prev, goal],
    );
  };

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      <div className="flex items-center p-4 pb-2 justify-between z-10">
        <Link
          href="/sign-up/step-1"
          className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors"
        >
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <div className="text-slate-900 dark:text-slate-100 font-semibold text-sm">
          Step 2 of 4
        </div>
        <div className="w-10"></div>
      </div>
      <div className="px-6 pb-2 z-10">
        <div className="w-full bg-slate-200 dark:bg-slate-800 rounded-full h-1.5">
          <div className="bg-primary h-1.5 rounded-full w-2/4"></div>
        </div>
      </div>
      <div className="px-6 pt-4 pb-4 z-10">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">
          Goals
        </h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">
          Tell us what you&apos;d like to achieve so we can tailor Recom24 to
          you.
        </p>
      </div>
      <form className="flex flex-col gap-6 px-6 py-2 mt-2 flex-grow z-10">
        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-4 flex items-center gap-2">
            <Briefcase className="text-primary w-6 h-6" />
            Career Goals
          </label>
          <div className="flex flex-wrap gap-3">
            {[
              "Career Change",
              "Entrepreneurship",
              "Leadership",
              "Networking",
              "Professional Certification",
              "Promotion",
              "Public Speaking",
              "Salary Growth",
              "Skill Development",
              "Team Management",
            ].map((goal) => {
              const isChecked = selectedCareerGoals.includes(goal);
              return (
                <label key={goal} className="cursor-pointer group">
                  <input
                    className="peer sr-only"
                    type="checkbox"
                    checked={isChecked}
                    onChange={() => toggleCareerGoal(goal)}
                  />
                  <div
                    className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${isChecked ? "bg-primary/10 text-primary border border-primary/20" : "bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800"}`}
                  >
                    {goal}
                  </div>
                </label>
              );
            })}
          </div>
        </div>

        <div className="flex flex-col w-full mt-2">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-4 flex items-center gap-2">
            <Smile className="text-primary w-6 h-6" />
            Lifestyle Goals
          </label>
          <div className="flex flex-wrap gap-3">
            {[
              "Fitness & Exercise",
              "Healthy Eating",
              "Mindfulness & Meditation",
              "Personal Growth",
              "Productivity",
              "Relationships",
              "Sleep Quality",
              "Stress Management",
              "Travel & Experiences",
              "Work-Life Balance",
            ].map((goal) => {
              const isChecked = selectedLifestyleGoals.includes(goal);
              return (
                <label key={goal} className="cursor-pointer group">
                  <input
                    className="peer sr-only"
                    type="checkbox"
                    checked={isChecked}
                    onChange={() => toggleLifestyleGoal(goal)}
                  />
                  <div
                    className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${isChecked ? "bg-primary/10 text-primary border border-primary/20" : "bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800"}`}
                  >
                    {goal}
                  </div>
                </label>
              );
            })}
          </div>
        </div>

        <div className="mt-auto pt-8 mb-2">
          <Link
            href="/sign-up/step-3"
            className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]"
          >
            Next
          </Link>
        </div>
      </form>
      <div className="px-6 pb-12 text-center z-10">
        <Link
          href="/sign-up/step-3"
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
