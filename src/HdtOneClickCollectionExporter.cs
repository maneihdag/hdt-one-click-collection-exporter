using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Windows.Controls;
using Hearthstone_Deck_Tracker.Hearthstone;
using Hearthstone_Deck_Tracker.Plugins;
using Newtonsoft.Json;

namespace HdtOneClickCollectionExporter
{
    public class Plugin : IPlugin
    {
        private DateTime _lastCheck = DateTime.MinValue;
        private bool _busy;

        public string Name
        {
            get { return "HDT One-Click Collection Exporter"; }
        }

        public string Description
        {
            get
            {
                return "One-click local JSON export of your Hearthstone collection. / " +
                       "Esportazione locale JSON con un clic della tua collezione di Hearthstone.";
            }
        }

        public string ButtonText
        {
            get { return "Export now / Esporta ora"; }
        }

        public string Author
        {
            get { return "maneihdag"; }
        }

        public Version Version
        {
            get { return new Version(1, 0, 0); }
        }

        public MenuItem MenuItem
        {
            get { return null; }
        }

        private static string Desktop
        {
            get { return Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory); }
        }

        private static string TriggerPath
        {
            get { return Path.Combine(Desktop, "HDT_ONECLICK_EXPORT.trigger"); }
        }

        private static string StatusPath
        {
            get { return Path.Combine(Desktop, "HDT_ONECLICK_EXPORT.status"); }
        }

        public void OnLoad() { }
        public void OnUnload() { }
        public void OnButtonPress() { ExportNow(); }

        public void OnUpdate()
        {
            if (_busy) return;
            if ((DateTime.Now - _lastCheck).TotalMilliseconds < 500) return;
            _lastCheck = DateTime.Now;
            if (!File.Exists(TriggerPath)) return;
            try { File.Delete(TriggerPath); } catch { }
            ExportNow();
        }

        private async void ExportNow()
        {
            if (_busy) return;
            _busy = true;

            try
            {
                var collection = await CollectionHelpers.Hearthstone.GetCollection();

                if (collection == null || collection.Cards == null || collection.Cards.Count == 0)
                {
                    throw new InvalidOperationException(
                        "HDT cannot read the Hearthstone collection yet. Open Hearthstone, reach the main menu, then try again. / " +
                        "HDT non riesce ancora a leggere la collezione. Apri Hearthstone, arriva al menu principale e riprova.");
                }

                var compactCollection = new SortedDictionary<int, int[]>();
                int normalTotal = 0;
                int goldenTotal = 0;
                int diamondTotal = 0;
                int signatureTotal = 0;

                foreach (var entry in collection.Cards)
                {
                    var counts = entry.Value ?? new int[0];
                    var normal = SafeCount(counts, 0);
                    var golden = SafeCount(counts, 1);
                    var diamond = SafeCount(counts, 2);
                    var signature = SafeCount(counts, 3);

                    if (normal + golden + diamond + signature <= 0)
                        continue;

                    compactCollection[entry.Key] = new[] { normal, golden, diamond, signature };
                    normalTotal += normal;
                    goldenTotal += golden;
                    diamondTotal += diamond;
                    signatureTotal += signature;
                }

                var payload = new ExportPayload
                {
                    FormatVersion = 1,
                    ExportedAt = DateTime.UtcNow.ToString("o"),
                    Source = "Hearthstone Deck Tracker",
                    Dust = collection.Dust,
                    Collection = compactCollection,
                    FavoriteHeroes = collection.FavoriteHeroes,
                    CardBacks = collection.CardBacks,
                    FavoriteCardBack = collection.FavoriteCardBack,
                    PlayerRecords = collection.PlayerRecords,
                    Summary = new ExportSummary
                    {
                        UniqueOwnedDbfIds = compactCollection.Count,
                        Normal = normalTotal,
                        Golden = goldenTotal,
                        Diamond = diamondTotal,
                        Signature = signatureTotal,
                        TotalOwned = normalTotal + goldenTotal + diamondTotal + signatureTotal
                    }
                };

                var json = JsonConvert.SerializeObject(payload, Formatting.Indented);
                var outputPath = Path.Combine(Desktop, "HDT_Collection.json");
                File.WriteAllText(outputPath, json, new UTF8Encoding(false));

                var archiveDir = Path.Combine(Desktop, "HDT Collection Archive");
                Directory.CreateDirectory(archiveDir);
                var archivePath = Path.Combine(archiveDir, "HDT_Collection_" + DateTime.Now.ToString("yyyy-MM-dd_HH-mm-ss") + ".json");
                File.WriteAllText(archivePath, json, new UTF8Encoding(false));

                File.WriteAllText(StatusPath, "OK|" + outputPath, new UTF8Encoding(false));
            }
            catch (Exception ex)
            {
                try { File.WriteAllText(StatusPath, "ERROR|" + ex.Message, new UTF8Encoding(false)); } catch { }
            }
            finally
            {
                _busy = false;
            }
        }

        private static int SafeCount(int[] counts, int index)
        {
            if (counts == null || index < 0 || index >= counts.Length) return 0;
            return Math.Max(0, counts[index]);
        }

        private class ExportPayload
        {
            [JsonProperty("format_version")] public int FormatVersion { get; set; }
            [JsonProperty("exported_at")] public string ExportedAt { get; set; }
            [JsonProperty("source")] public string Source { get; set; }
            [JsonProperty("dust")] public int Dust { get; set; }
            [JsonProperty("collection")] public SortedDictionary<int, int[]> Collection { get; set; }
            [JsonProperty("favorite_heroes")] public SortedDictionary<int, int> FavoriteHeroes { get; set; }
            [JsonProperty("cardbacks")] public List<int> CardBacks { get; set; }
            [JsonProperty("favorite_cardback")] public int FavoriteCardBack { get; set; }
            [JsonProperty("player_records")] public SortedDictionary<int, SortedDictionary<int, int[]>> PlayerRecords { get; set; }
            [JsonProperty("summary")] public ExportSummary Summary { get; set; }
        }

        private class ExportSummary
        {
            [JsonProperty("unique_owned_dbf_ids")] public int UniqueOwnedDbfIds { get; set; }
            [JsonProperty("normal")] public int Normal { get; set; }
            [JsonProperty("golden")] public int Golden { get; set; }
            [JsonProperty("diamond")] public int Diamond { get; set; }
            [JsonProperty("signature")] public int Signature { get; set; }
            [JsonProperty("total_owned")] public int TotalOwned { get; set; }
        }
    }
}
