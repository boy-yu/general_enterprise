/*
 * Copyright 2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.internal.fingerprint;

import org.gradle.internal.snapshot.CompleteFileSystemLocationSnapshot;
import org.gradle.internal.snapshot.FileSystemSnapshot;

import java.util.Map;

/**
 * Strategy for converting a sequence of {@link CompleteFileSystemLocationSnapshot}s into a {@link FileCollectionFingerprint}.
 */
public interface FingerprintingStrategy {

    // TODO wolfs: Move these identifiers to the actual strategy classes when they live in :snapshots
    String CLASSPATH_IDENTIFIER = "CLASSPATH";
    String COMPILE_CLASSPATH_IDENTIFIER = "COMPILE_CLASSPATH";

    /**
     * Converts the roots into the {@link FileSystemLocationFingerprint}s used by the {@link FileCollectionFingerprint}.
     */
    Map<String, FileSystemLocationFingerprint> collectFingerprints(Iterable<? extends FileSystemSnapshot> roots);

    /**
     * Used by the {@link FileCollectionFingerprint} to hash a map of fingerprints generated by {@link #collectFingerprints(Iterable)}
     */
    FingerprintHashingStrategy getHashingStrategy();

    /**
     * UsedByScansPlugin
     * Names are expected as part of org.gradle.api.internal.tasks.SnapshotTaskInputsBuildOperationType.Result.VisitState.getPropertyNormalizationStrategyName().
     */
    String getIdentifier();

    CurrentFileCollectionFingerprint getEmptyFingerprint();

    String normalizePath(CompleteFileSystemLocationSnapshot snapshot);
}
