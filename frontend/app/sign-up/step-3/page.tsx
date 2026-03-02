"use client";

import Link from "next/link";
import {
  ArrowLeft,
  FileText,
  GraduationCap,
  Heart,
  PlayCircle,
  SlidersHorizontal,
} from "lucide-react";
import { useState } from "react";

export default function SignupStep3() {
  const [selectedInterests, setSelectedInterests] = useState<string[]>([]);
  const [selectedFormats, setSelectedFormats] = useState<string[]>([]);

  const toggleInterest = (interest: string) => {
    setSelectedInterests((prev) =>
      prev.includes(interest)
        ? prev.filter((i) => i !== interest)
        : [...prev, interest],
    );
  };

  const toggleFormat = (format: string) => {
    setSelectedFormats((prev) =>
      prev.includes(format)
        ? prev.filter((f) => f !== format)
        : [...prev, format],
    );
  };

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      <div className="flex items-center p-4 pb-2 justify-between z-10">
        <Link
          href="/sign-up/step-2"
          className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors"
        >
          <ArrowLeft className="w-6 h-6" />
        </Link>
        <div className="text-slate-900 dark:text-slate-100 font-semibold text-sm">
          Step 3 of 4
        </div>
        <div className="w-10"></div>
      </div>

      <div className="px-6 pb-2 z-10">
        <div className="w-full bg-slate-200 dark:bg-slate-800 rounded-full h-1.5">
          <div className="bg-primary h-1.5 rounded-full w-3/4"></div>
        </div>
      </div>

      <div className="px-6 pt-4 pb-4 z-10">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">
          Interests & Preferences
        </h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">
          Pick the topics and formats you enjoy most so we can personalize
          Recom24 for you.
        </p>
      </div>

      <form className="flex flex-col gap-6 px-6 py-2 mt-2 flex-grow z-10">
        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-3 flex items-center gap-2">
            <Heart className="text-primary w-5 h-5" />
            Interests
          </label>
          <div className="flex flex-wrap gap-2.5">
            {[
              "AI & ML",
              "Career Growth",
              "Coding",
              "Cybersecurity",
              "Finance",
              "Leadership",
              "Marketing",
              "Personal Development",
              "Productivity",
              "Public Speaking",
            ].map((interest) => {
              const isChecked = selectedInterests.includes(interest);
              return (
                <label key={interest} className="cursor-pointer group">
                  <input
                    className="peer sr-only"
                    type="checkbox"
                    checked={isChecked}
                    onChange={() => toggleInterest(interest)}
                  />
                  <div
                    className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${isChecked ? "bg-primary/10 text-primary border border-primary/20" : "bg-white dark:bg-slate-900/50 text-slate-600 dark:text-slate-400 border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800"}`}
                  >
                    {interest}
                  </div>
                </label>
              );
            })}
          </div>
        </div>

        <div className="h-px w-full bg-slate-200 dark:bg-slate-800 my-2"></div>

        <div className="flex flex-col w-full">
          <label className="text-slate-900 dark:text-slate-100 text-lg font-bold mb-4 flex items-center gap-2">
            <SlidersHorizontal className="text-primary w-5 h-5" />
            Content Format
          </label>
          <div className="grid grid-cols-3 gap-3">
            {[
              { id: "Article", icon: FileText },
              { id: "Course", icon: GraduationCap },
              { id: "Video", icon: PlayCircle },
            ].map((format) => {
              const isChecked = selectedFormats.includes(format.id);
              const Icon = format.icon;
              return (
                <label
                  key={format.id}
                  className="cursor-pointer group relative"
                >
                  <input
                    className="peer sr-only"
                    type="checkbox"
                    checked={isChecked}
                    onChange={() => toggleFormat(format.id)}
                  />
                  <div
                    className={`flex flex-col items-center justify-center p-3 py-4 rounded-xl transition-all ${isChecked ? "bg-primary/10 border-primary/20 shadow-sm shadow-primary/10 border" : "bg-white dark:bg-slate-900/50 border border-slate-200 dark:border-slate-800 hover:bg-slate-100 dark:hover:bg-slate-800"}`}
                  >
                    <Icon
                      className={`w-6 h-6 mb-1 ${isChecked ? "text-primary" : "text-slate-600 dark:text-slate-400"}`}
                    />
                    <span
                      className={`text-xs ${isChecked ? "text-primary font-semibold" : "font-medium text-slate-600 dark:text-slate-400"}`}
                    >
                      {format.id}
                    </span>
                  </div>
                </label>
              );
            })}
          </div>
        </div>

        <div className="mt-auto pt-8 mb-2">
          <Link
            href="/sign-up/step-4"
            className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]"
          >
            Next
          </Link>
        </div>
      </form>

      <div className="px-6 pb-12 text-center z-10">
        <Link
          href="/sign-up/step-4"
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
