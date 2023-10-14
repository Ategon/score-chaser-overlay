import { Client, Events, GatewayIntentBits } from "discord.js";
import "dotenv/config";
import { readFileSync, writeFile } from "fs";

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

client.on(Events.MessageCreate, (message) => {
  if (message.channelId == "964243131656716288") {
    if (isNaN(message.content)) {
      message.react("❌");
    } else {
      let file = readFileSync("../data/data.txt", {
        encoding: "utf8",
        flag: "r",
      });

      file = file.split("\n");
      let handled = false;

      file.forEach((row, index) => {
        const rowData = row.split("|");
        if (rowData.length <= 1) return;

        if (rowData[0] == message.author.id) {
          if (parseInt(rowData[1]) < parseInt(message.content)) {
            rowData[1] = message.content;
            message.react("✅");
            handled = true;
            file[index] = rowData.join("|");
          } else {
            message.react("🔽");
            handled = true;
          }
        }
      });

      if (!handled) {
        file[file.length - 1] = `${message.author.id}|${message.content}`;
        file.push("");
        message.react("✅");
      }

      writeFile("../data/data.txt", file.join("\n"), (err) => {
        if (err) {
          console.error(err);
        }
        // file written successfully
      });
    }
  }
});

client.login(process.env.DISCORD_TOKEN);
