import { Client, Events, GatewayIntentBits } from "discord.js";
import "dotenv/config";
import { readFileSync, writeFile } from "fs";
import EventSource from "eventsource";
import { throttle } from "throttle-debounce";

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds,
    GatewayIntentBits.MessageContent,
    GatewayIntentBits.GuildMessages,
  ],
});

client.once(Events.ClientReady, (c) => {
  console.log(`Ready! Logged in as ${c.user.tag}`);
});

const nothing = () => {};
let queue = [];

const updateScore = (who, score, cb = nothing) => {
  queue.push([who, score, cb]);
  updateBatch();
};

const updateBatch = throttle(1000, () => {
  let file = [];
  try {
    file = readFileSync("../data/data.txt", {
      encoding: "utf8",
      flag: "r",
    });
    file = file.split("\n");
  } catch (e) {
    console.log("Re-creating data.txt ...");
  }

  queue.forEach(([who, score, cb]) => {
    let handled = false;

    file.forEach((row, index) => {
      const rowData = row.split("|");
      if (rowData.length <= 1) return;

      if (rowData[0] == who) {
        if (parseInt(rowData[1]) < parseInt(score)) {
          rowData[1] = score;
          cb("✅");
          handled = true;
          file[index] = rowData.join("|");
        } else {
          cb("🔽");
          handled = true;
        }
      }
    });

    if (!handled) {
      file[file.length - 1] = `${who}|${score}`;
      file.push("");
      cb("✅");
    }
  });

  // clear the queue
  queue = [];

  writeFile("../data/data.txt", file.join("\n"), (err) => {
    if (err) {
      console.error(err);
    }
    // file written successfully
  });
});
client.on(Events.MessageCreate, (message) => {
  if (message.channelId == "1066389810371117146") {
    if (isNaN(message.content)) {
      message.react("❌");
    } else {
      updateScore(message.author.id, message.content, (s) => message.react(s));
    }
  }
});

client.login(process.env.DISCORD_TOKEN);

// connect to bit golf API
const es = new EventSource("https://ld54.badcop.games/event/sse");
es.addEventListener("update", (e) => {
  let [who, score] = e.data.split(":");
  updateScore(who, -parseInt(score));
});
