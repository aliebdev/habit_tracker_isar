import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import '../components/my_habit_tile.dart';
import '../components/my_heat_map.dart';
import '../database/habit_database.dart';
import '../models/habit.dart';
import '../utils/app_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    context.read<HabitDatabase>().readHabits();
    super.initState();
  }

  @override
  void dispose() {
    textController.clear();
    super.dispose();
  }

  void createOrEditHabit([Habit? habit]) {
    bool isEdit = habit != null;
    if (isEdit) {
      textController.text = habit.name;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          autofocus: true,
          controller: textController,
          decoration: const InputDecoration(hintText: "Create a new habit"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              String newHabitName = textController.text.trim();

              if (newHabitName == "") return;

              if (isEdit) {
                context
                    .read<HabitDatabase>()
                    .updateHabitName(habit.id, newHabitName);
              } else {
                context.read<HabitDatabase>().addHabit(newHabitName);
              }

              Navigator.pop(context);

              textController.clear();
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              textController.clear();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Are you sure want to delete?"),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<HabitDatabase>().deleteHabit(habit.id);

              Navigator.pop(context);

              textController.clear();
            },
            child: const Text("Delete"),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final habitDatabase = context.watch<HabitDatabase>();
    final List<Habit> currentHabits = habitDatabase.currentHabits;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(0, 176, 61, 61),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createOrEditHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          FutureBuilder<DateTime?>(
            future: habitDatabase.getFirstLaunchDate(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MyHeatMap(
                  startDate: snapshot.data!,
                  datasets: AppUtils.prepareHeatMapDataset(currentHabits),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: currentHabits.length,
            itemBuilder: (BuildContext context, int index) {
              final habit = currentHabits.elementAt(index);
              bool isCompletedToday =
                  AppUtils.isHabitCompletedToday(habit.completedDays);
              return MyHabitTile(
                text: habit.name,
                isCompleted: isCompletedToday,
                onChanged: (value) => checkHabitOnOff(value, habit),
                editHabit: (context) => createOrEditHabit(habit),
                deleteHabit: (context) => deleteHabitBox(habit),
              );
            },
          ),
        ],
      ),
    );
  }
}
