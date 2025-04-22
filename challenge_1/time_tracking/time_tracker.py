import json
import os
from datetime import datetime

class TimeTracker:
    def __init__(self, filename='time_log.json'):
        self.filename = filename
        self.data = self._load_data()

    def _load_data(self):
        if os.path.exists(self.filename):
            with open(self.filename, 'r') as f:
                return json.load(f)
        return {
            "project": {},
            "features": {}
        }

    def _save_data(self):
        with open(self.filename, 'w') as f:
            json.dump(self.data, f, indent=4)

    def _current_time(self):
        return datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    def _calc_duration(self, start, end):
        start_dt = datetime.strptime(start, '%Y-%m-%d %H:%M:%S')
        end_dt = datetime.strptime(end, '%Y-%m-%d %H:%M:%S')
        return str(end_dt - start_dt)

    def start_project(self):
        self.data['project']['start_time'] = self._current_time()
        self._save_data()
        print("Project started.")

    def end_project(self):
        self.data['project']['end_time'] = self._current_time()
        self.data['project']['duration'] = self._calc_duration(
            self.data['project']['start_time'],
            self.data['project']['end_time']
        )
        self._save_data()
        print("Project ended.")

    def start_feature(self, name):
        if name not in self.data['features']:
            self.data['features'][name] = {}
        self.data['features'][name]['start_time'] = self._current_time()
        self._save_data()
        print(f"Feature '{name}' started.")

    def end_feature(self, name):
        if name in self.data['features'] and 'start_time' in self.data['features'][name]:
            self.data['features'][name]['end_time'] = self._current_time()
            self.data['features'][name]['duration'] = self._calc_duration(
                self.data['features'][name]['start_time'],
                self.data['features'][name]['end_time']
            )
            self._save_data()
            print(f"Feature '{name}' ended.")
        else:
            print(f"Feature '{name}' has not been started.")
