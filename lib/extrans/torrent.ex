defmodule ExTrans.Torrent do
  alias ExTrans.Base

  @fields [
    "activityDate", "addedDate", "bandwidthPriority", "comment", "corruptEver", "creator", "dateCreated", "desiredAvailable", "doneDate", "downloadDir", "downloadedEver", "downloadLimit", "downloadLimited", "error", "errorString", "eta", "etaIdle", "files", "fileStats", "hashString", "haveUnchecked", "haveValid", "honorsSessionLimits", "id", "isFinished", "isPrivate", "isStalled", "leftUntilDone", "magnetLink", "manualAnnounceTime", "maxConnectedPeers", "metadataPercentComplete", "name", "peer", "peers", "peersConnected", "peersFrom", "peersGettingFromUs", "peersSendingToUs", "percentDone", "pieces", "pieceCount", "pieceSize", "priorities", "queuePosition", "rateDownload", "rateUpload", "recheckProgress", "secondsDownloading", "secondsSeeding", "seedIdleLimit", "seedIdleMode", "seedRatioLimit", "seedRatioMode", "sizeWhenDone", "startDate", "status", "trackers", "trackerStats", "totalSize", "torrentFile", "uploadedEver", "uploadLimit", "uploadLimited", "uploadRatio", "wanted", "webseeds", "webseedsSendingToUs"
  ]

  def start do
    Base.call("torrent-start")
  end

  def start_now do
    Base.call("torrent-start-now")
  end

  def stop do
    Base.call("torrent-stop")
  end

  def verify do
    Base.call("torrent-verify")
  end

  def reannounce do
    Base.call("torrent-reannounce")
  end

  def set do
    Base.call("torrent-set")
  end

  def get(fields) do
    Base.call("torrent-get", %{"fields" => fields})
  end

  def get do
    get(@fields)
  end

  def add(url, args \\ %{}) do
    Base.call("torrent-add", Map.merge(%{"filename" => url}, args))
  end

  def remove do
    Base.call("torrent-remove")
  end
end