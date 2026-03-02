"use client";

import Link from "next/link";
import { ArrowLeft, Eye, EyeOff } from "lucide-react";
import { useState } from "react";

export default function LoginScreen() {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <div className="relative flex min-h-screen w-full flex-col bg-background-light dark:bg-background-dark overflow-x-hidden max-w-md mx-auto">
      {/* Top Navigation */}
      <div className="flex items-center p-4 pb-2 justify-between">
        <Link
          href="/"
          className="text-slate-900 dark:text-slate-100 flex size-10 items-center justify-center rounded-full hover:bg-primary/10 transition-colors"
        >
          <ArrowLeft className="w-6 h-6" />
        </Link>
      </div>

      {/* Header Section */}
      <div className="px-6 pt-8 pb-4">
        <h1 className="text-slate-900 dark:text-slate-100 tracking-tight text-3xl font-bold leading-tight">
          Welcome Back
        </h1>
        <p className="text-slate-600 dark:text-slate-400 text-base font-normal mt-2">
          Sign in to access your personalized Recom24 experience.
        </p>
      </div>

      {/* Form Section */}
      <form className="flex flex-col gap-4 px-6 py-4 mt-4 flex-grow">
        {/* Email Input */}
        <div className="flex flex-col w-full">
          <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold mb-2">
            Email Address
          </label>
          <input
            className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-14 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none"
            placeholder="Enter your email"
            type="email"
          />
        </div>

        {/* Password Input */}
        <div className="flex flex-col w-full">
          <div className="flex justify-between items-center mb-2">
            <label className="text-slate-700 dark:text-slate-300 text-sm font-semibold">
              Password
            </label>
          </div>
          <div className="relative flex w-full items-stretch">
            <input
              className="form-input flex w-full rounded-lg border border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900/50 text-slate-900 dark:text-slate-100 focus:border-primary focus:ring-1 focus:ring-primary h-14 px-4 text-base placeholder:text-slate-400 dark:placeholder:text-slate-600 transition-all outline-none"
              type={showPassword ? "text" : "password"}
              placeholder="Enter your password"
            />
            <button
              className="absolute right-0 h-14 px-4 flex items-center justify-center text-slate-400 hover:cursor-pointer hover:text-primary transition-colors"
              type="button"
              onClick={() => setShowPassword(!showPassword)}
            >
              {showPassword ? (
                <EyeOff className="w-5 h-5" />
              ) : (
                <Eye className="w-5 h-5" />
              )}
            </button>
          </div>
          <div className="flex justify-end mt-2">
            <a
              className="text-primary text-sm font-medium hover:underline"
              href="#"
            >
              Forgot Password?
            </a>
          </div>
        </div>

        {/* Action Button */}
        <div className="mt-6">
          <Link
            href="/alerts"
            className="w-full bg-primary hover:bg-primary/90 text-white font-bold h-14 rounded-xl shadow-lg shadow-primary/20 flex items-center justify-center transition-all active:scale-[0.98]"
          >
            Sign In
          </Link>
        </div>
      </form>

      {/* Footer */}
      <div className="mt-auto px-6 pb-12 text-center z-10">
        <p className="text-slate-500 dark:text-slate-400 text-sm">
          Don&apos;t have an account?
          <Link
            className="text-primary font-semibold hover:underline ml-1"
            href="/sign-up/step-1"
          >
            Register here
          </Link>
        </p>
      </div>

      {/* Decorative Element */}
      <div className="fixed -top-24 -right-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl pointer-events-none"></div>
      <div className="fixed -bottom-24 -left-24 w-64 h-64 bg-primary/10 rounded-full blur-3xl pointer-events-none"></div>
    </div>
  );
}
