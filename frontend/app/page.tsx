import Image from 'next/image';
import Link from 'next/link';
import { FileText, GraduationCap, PlayCircle, ThumbsUp } from 'lucide-react';

export default function WelcomeScreen() {
  return (
    <div className="relative flex min-h-screen w-full flex-col overflow-hidden max-w-md mx-auto shadow-2xl bg-white dark:bg-[#101622]">
      <div className="absolute inset-0 z-0">
        <Image
          alt="Corporate Office Background"
          className="h-full w-full object-cover opacity-20 dark:opacity-10 filter grayscale mix-blend-overlay"
          src="https://picsum.photos/seed/office/1080/1920"
          fill
          referrerPolicy="no-referrer"
        />
        <div className="absolute inset-0 bg-gradient-to-b from-primary/10 via-transparent to-background-light dark:from-blue-900/20 dark:to-[#101622]"></div>
      </div>
      <div className="relative z-10 flex flex-1 flex-col p-6">
        <div className="flex justify-center pt-8 pb-4">
          <div className="flex items-center gap-2">
            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-primary text-white shadow-lg shadow-blue-500/30">
              <ThumbsUp className="w-6 h-6" />
            </div>
            <h1 className="text-2xl font-bold tracking-tight text-slate-900 dark:text-white">
              Recom<span className="text-primary">24</span>
            </h1>
          </div>
        </div>
        <div className="flex flex-1 flex-col justify-center gap-6 py-8">
          <div className="text-center mb-4">
            <h2 className="text-3xl font-extrabold text-slate-900 dark:text-white leading-tight mb-3">
              Master your skills with tailored content
            </h2>
            <p className="text-slate-500 dark:text-slate-400 text-lg leading-relaxed">
              Personalized corporate learning recommendations delivered straight to you.
            </p>
          </div>
          <div className="grid grid-cols-1 gap-4">
            <div className="flex items-center gap-4 p-4 rounded-2xl bg-white/60 dark:bg-slate-800/40 border border-slate-200/50 dark:border-slate-700/50 shadow-sm backdrop-blur-sm">
              <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-green-100 dark:bg-green-500/10 text-green-600 dark:text-green-400">
                <FileText className="w-6 h-6" />
              </div>
              <div>
                <h3 className="font-bold text-slate-900 dark:text-white">Curated Articles</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">Industry insights daily</p>
              </div>
            </div>
            <div className="flex items-center gap-4 p-4 rounded-2xl bg-white/60 dark:bg-slate-800/40 border border-slate-200/50 dark:border-slate-700/50 shadow-sm backdrop-blur-sm">
              <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-blue-100 dark:bg-blue-500/10 text-blue-600 dark:text-blue-400">
                <GraduationCap className="w-6 h-6" />
              </div>
              <div>
                <h3 className="font-bold text-slate-900 dark:text-white">Expert Courses</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">Deep dive learning modules</p>
              </div>
            </div>
            <div className="flex items-center gap-4 p-4 rounded-2xl bg-white/60 dark:bg-slate-800/40 border border-slate-200/50 dark:border-slate-700/50 shadow-sm backdrop-blur-sm">
              <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-purple-100 dark:bg-purple-500/10 text-purple-600 dark:text-purple-400">
                <PlayCircle className="w-6 h-6" />
              </div>
              <div>
                <h3 className="font-bold text-slate-900 dark:text-white">Engaging Videos</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">Visual learning on demand</p>
              </div>
            </div>
          </div>
        </div>
        <div className="mt-auto flex flex-col gap-3 pb-8">
          <Link href="/signup" className="flex w-full items-center justify-center rounded-xl bg-primary px-6 py-4 text-base font-bold text-white shadow-lg shadow-blue-500/25 transition-all hover:bg-primary-dark active:scale-[0.98]">
            Sign Up
          </Link>
          <Link href="/login" className="flex w-full items-center justify-center rounded-xl bg-white dark:bg-slate-800 px-6 py-4 text-base font-bold text-slate-900 dark:text-white border border-slate-200 dark:border-slate-700 shadow-sm transition-all hover:bg-slate-50 dark:hover:bg-slate-700 active:scale-[0.98]">
            Sign In
          </Link>
          <p className="mt-4 text-center text-xs text-slate-400 dark:text-slate-500">
            By continuing, you agree to our Terms of Service.
          </p>
        </div>
      </div>
    </div>
  );
}
