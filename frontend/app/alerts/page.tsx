"use client";

import Link from "next/link";
import {
  Bell,
  Calendar,
  CheckCheck,
  CheckCircle2,
  CircleQuestionMark,
  FileText,
  GraduationCap,
  Home,
  PlayCircle,
  User,
} from "lucide-react";
import { useEffect, useMemo, useState } from "react";

type RecommendationItem = {
  id: string;
  description: string;
  isComplete: boolean;
  link: string;
  title: string;
  type: string;
  createdAt: string;
};

type RecommendationsResponse = {
  items: RecommendationItem[];
};

type GroupedRecommendations = Record<string, RecommendationItem[]>;

const baseUrl = process.env.NEXT_PUBLIC_API_BASE_URL ?? "http://localhost:8000";

export default function AlertsScreen() {
  const [data, setData] = useState<RecommendationsResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [expandedItems, setExpandedItems] = useState<Record<string, boolean>>(
    {},
  );

  useEffect(() => {
    const fetchData = async () => {
      try {
        if (typeof window === "undefined") return;
        const token = localStorage.getItem("access_token");
        if (!token) {
          setError("Please sign in to see your alerts.");
          setLoading(false);
          return;
        }

        const res = await fetch(`${baseUrl}/recommendations`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        });

        if (!res.ok) {
          const body = await res.json().catch(() => ({}));
          const message =
            body.detail || body.message || "Failed to load alerts.";
          throw new Error(message);
        }

        const json = (await res.json()) as RecommendationsResponse;
        setData(json);
      } catch (err: any) {
        setError(err?.message ?? "Something went wrong while loading alerts.");
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  const grouped = useMemo((): GroupedRecommendations => {
    if (!data) return {};
    const byDate: GroupedRecommendations = {};

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    for (const item of data.items) {
      const dt = new Date(item.createdAt);
      const day = new Date(dt);
      day.setHours(0, 0, 0, 0);
      const diffDays = Math.floor(
        (today.getTime() - day.getTime()) / (1000 * 60 * 60 * 24),
      );

      let label: string;
      if (diffDays === 0) label = "Today";
      else if (diffDays === 1) label = "Yesterday";
      else if (diffDays >= 2 && diffDays <= 6) label = `${diffDays} days ago`;
      else
        label = day.toLocaleDateString(undefined, {
          month: "short",
          day: "numeric",
        });

      if (!byDate[label]) byDate[label] = [];
      byDate[label].push(item);
    }

    Object.keys(byDate).forEach((key) => {
      byDate[key].sort(
        (a, b) =>
          new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime(),
      );
    });

    return byDate;
  }, [data]);

  const hasAny = data && data.items.length > 0;

  const markAsComplete = async (itemId: string) => {
    const token = localStorage.getItem("access_token");
    if (!token || !data) return;
    const previous = data;
    setData((prev) =>
      prev
        ? {
            items: prev.items.map((it) =>
              it.id === itemId ? { ...it, isComplete: true } : it,
            ),
          }
        : null,
    );
    setError(null);
    try {
      const res = await fetch(`${baseUrl}/recommendations/${itemId}/complete`, {
        method: "PATCH",
        headers: { Authorization: `Bearer ${token}` },
      });
      if (!res.ok) {
        setData(previous);
        const body = await res.json().catch(() => ({}));
        setError(body.detail || body.message || "Failed to mark as complete.");
      }
    } catch {
      setData(previous);
      setError("Something went wrong. Please try again.");
    }
  };

  const renderCard = (item: RecommendationItem) => {
    const type = item.type.toLowerCase();
    const isArticle = type === "article";
    const isCourse = type === "course";
    const isVideo = type === "video";

    const Icon = isArticle
      ? FileText
      : isCourse
        ? GraduationCap
        : isVideo
          ? PlayCircle
          : CircleQuestionMark;
    const typeLabel = isArticle
      ? "Article"
      : isCourse
        ? "Course"
        : isVideo
          ? "Video"
          : "Unknown";

    const colorClasses = isArticle
      ? {
          icon: "bg-sky-100 text-sky-600 dark:bg-sky-900/40 dark:text-sky-300",
          tag: "bg-sky-100 text-sky-700 ring-sky-200 dark:bg-sky-900/40 dark:text-sky-200 dark:ring-sky-800",
        }
      : isCourse
        ? {
            icon: "bg-emerald-100 text-emerald-600 dark:bg-emerald-900/40 dark:text-emerald-300",
            tag: "bg-emerald-100 text-emerald-700 ring-emerald-200 dark:bg-emerald-900/40 dark:text-emerald-200 dark:ring-emerald-800",
          }
        : isVideo
          ? {
              icon: "bg-violet-100 text-violet-600 dark:bg-violet-900/40 dark:text-violet-300",
              tag: "bg-violet-100 text-violet-700 ring-violet-200 dark:bg-violet-900/40 dark:text-violet-200 dark:ring-violet-800",
            }
          : {
              icon: "bg-slate-100 text-slate-600 dark:bg-slate-800 dark:text-slate-200",
              tag: "bg-slate-100 text-slate-700 ring-slate-200 dark:bg-slate-800 dark:text-slate-200 dark:ring-slate-700",
            };

    const created = new Date(item.createdAt);
    const timeLabel = created.toLocaleTimeString(undefined, {
      hour: "numeric",
      minute: "2-digit",
    });

    const isExpanded = !!expandedItems[item.id];
    const shouldTruncate = item.description.length > 100;
    const displayDescription =
      isExpanded || !shouldTruncate
        ? item.description
        : `${item.description.slice(0, 100)}…`;

    return (
      <div key={item.id} className="block px-4 py-2">
        <div className="flex items-start gap-4 rounded-xl bg-white dark:bg-[#1c2230] p-4 shadow-sm border border-slate-100 dark:border-slate-800 hover:bg-slate-50 dark:hover:bg-[#202736] transition-colors">
          <a
            href={item.link}
            target="_blank"
            rel="noreferrer"
            className="flex flex-1 items-start gap-4 min-w-0"
          >
            <div className="flex-shrink-0 mt-1">
              <div
                className={`flex h-10 w-10 items-center justify-center rounded-full ${colorClasses.icon}`}
              >
                <Icon className="w-5 h-5" />
              </div>
            </div>
            <div className="flex flex-1 flex-col gap-2 min-w-0">
              <div className="flex flex-col gap-1">
                <div className="flex justify-between items-start">
                  <p className="text-slate-900 dark:text-white text-base font-bold leading-tight">
                    {item.title}
                  </p>
                  <span className="text-xs text-slate-400 dark:text-slate-500 whitespace-nowrap ml-2">
                    {timeLabel}
                  </span>
                </div>
                <p className="text-slate-500 dark:text-slate-400 text-sm font-normal leading-normal">
                  {displayDescription}
                  {shouldTruncate && (
                    <button
                      type="button"
                      onClick={(e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        setExpandedItems((prev) => ({
                          ...prev,
                          [item.id]: !isExpanded,
                        }));
                      }}
                      className="ml-1 text-xs font-semibold text-primary hover:cursor-pointer hover:underline"
                    >
                      {isExpanded ? "See less" : "See more"}
                    </button>
                  )}
                </p>
              </div>
              <div className="mt-2 flex items-center justify-between">
                <span
                  className={`inline-flex items-center rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset ${colorClasses.tag}`}
                >
                  {typeLabel}
                </span>
                <div className="flex items-center">
                  {item.isComplete ? (
                    <span className="flex items-center gap-1.5 text-xs font-medium text-green-500">
                      <CheckCheck className="w-4 h-4" />
                      Completed
                    </span>
                  ) : (
                    <button
                      type="button"
                      onClick={(e) => {
                        e.preventDefault();
                        e.stopPropagation();
                        markAsComplete(item.id);
                      }}
                      className="flex items-center gap-1.5 text-xs font-semibold text-primary hover:cursor-pointer hover:underline"
                    >
                      <CheckCircle2 className="w-4 h-4" />
                      Mark as Complete
                    </button>
                  )}
                </div>
              </div>
            </div>
          </a>
        </div>
      </div>
    );
  };

  return (
    <div className="relative flex min-h-screen w-full flex-col overflow-x-hidden overflow-y-auto max-w-md mx-auto shadow-2xl bg-background-light dark:bg-background-dark">
      <div className="fixed top-0 left-1/2 -translate-x-1/2 z-10 flex items-center justify-center w-full max-w-md bg-background-light dark:bg-background-dark px-4 py-6 border-b border-slate-200 dark:border-slate-800">
        <h2 className="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] text-center">
          Alerts
        </h2>
      </div>

      <div className="flex-1 pb-24 mt-20">
        {loading && (
          <p className="px-4 pt-6 text-sm text-slate-500 dark:text-slate-400">
            Loading your alerts...
          </p>
        )}

        {!loading && error && (
          <p className="px-4 pt-6 text-sm text-red-500" role="alert">
            {error}
          </p>
        )}

        {!loading && !error && !hasAny && (
          <p className="px-4 pt-6 text-sm text-slate-500 dark:text-slate-400">
            No alerts yet. We&apos;ll start sending you recommendations soon.
          </p>
        )}

        {!loading &&
          !error &&
          hasAny &&
          Object.entries(grouped).map(([label, items]) => (
            <div key={label}>
              <h3 className="text-slate-500 dark:text-slate-400 text-sm font-bold uppercase tracking-wider px-4 pb-2 pt-6">
                {label}
              </h3>
              {items.map(renderCard)}
            </div>
          ))}

        <div className="h-10"></div>
      </div>

      <div className="fixed bottom-0 w-full max-w-md border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-[#1c2230] px-4 pb-6 pt-2 z-20">
        <div className="flex gap-2 justify-between">
          <Link
            href="/"
            className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors"
          >
            <div className="flex h-8 items-center justify-center">
              <Home className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">
              Home
            </p>
          </Link>
          <Link
            href="#"
            className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors"
          >
            <div className="flex h-8 items-center justify-center">
              <Calendar className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">
              Plan
            </p>
          </Link>
          <Link
            href="/alerts"
            className="flex flex-1 flex-col items-center justify-end gap-1 rounded-full text-primary"
          >
            <div className="flex h-8 items-center justify-center relative">
              <Bell className="w-6 h-6 fill-current" />
              <span className="absolute top-1 right-0.5 h-2 w-2 rounded-full bg-red-500 border border-white dark:border-[#1c2230]"></span>
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">
              Alerts
            </p>
          </Link>
          <Link
            href="#"
            className="flex flex-1 flex-col items-center justify-end gap-1 text-slate-400 dark:text-slate-500 hover:text-primary dark:hover:text-primary transition-colors"
          >
            <div className="flex h-8 items-center justify-center">
              <User className="w-6 h-6" />
            </div>
            <p className="text-xs font-medium leading-normal tracking-[0.015em]">
              Profile
            </p>
          </Link>
        </div>
      </div>
    </div>
  );
}
