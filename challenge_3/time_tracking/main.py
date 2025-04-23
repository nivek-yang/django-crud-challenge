import sys
from time_tracking.time_tracker import TimeTracker

tracker = TimeTracker()

def main():
    if len(sys.argv) < 2:
        print("Usage: python main.py [command] [feature_name (optional)]")
        sys.exit(1)

    command = sys.argv[1]
    feature = sys.argv[2] if len(sys.argv) >= 3 else None

    if command == "start_project":
        tracker.start_project()
    elif command == "end_project":
        tracker.end_project()
    elif command == "start_feature" and feature:
        tracker.start_feature(feature)
    elif command == "end_feature" and feature:
        tracker.end_feature(feature)
    elif command == "status":
        tracker.print_status()
    else:
        print("Invalid command or missing feature name.")

if __name__ == "__main__":
    main()